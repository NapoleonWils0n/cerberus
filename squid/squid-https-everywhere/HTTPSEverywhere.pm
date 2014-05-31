# Copyright (c) 2010  Mike Cardwell
#
# See LICENSE section in pod text below for usage and distribution rights.
#

package HTTPSEverywhere;

use strict;
use warnings;
use XML::LibXML;

sub new {
   my $class = shift;
   my %args  = @_;

   die "Missing rulesets arg" unless exists $args{rulesets};

   my $paths = ref($args{rulesets}) eq 'ARRAY' ? $args{rulesets} : [$args{rulesets}];

   my $self = bless {
      paths => $paths,
      enable_default_off_rulesets => $args{enable_default_off_rulesets} ? 1 : 0,
   }, $class;

   $self->read();

   return $self;
}

sub convert {
   my( $self, $url ) = @_;

   return $url unless $url =~ m#^http://(?:[^\@\/]+\@)?([-a-z0-9\.]+)(/.*)?$#i;
   my( $host, $uri ) = ( lc($1), $2||'/' );

   my $newurl = "http://$host$uri";

   ## Split the host into parts for the <target/> checks
     my $host_split = [split(/\./,$host)];

   ## Traverse each ruleset
     foreach my $path ( sort keys %{$self->{ruleset}} ){

        ## <target/>
          my $match_target = 1;
          foreach my $target (  @{$self->{ruleset}{$path}{t}} ){
             $match_target = 0;

             next unless int(@$target) == int(@$host_split);
             for( my $n = int(@$target)-1; $n >= 0; --$n ){
                last unless $target->[$n] eq $host_split->[$n] || $target->[$n] eq '*';
                $match_target = 1 if $n == 0;
             }
             last if $match_target;
          }
          next unless $match_target;

        ## If we haven't parsed out the exclusions/rules yet, do so now
	  $self->_full_parse( $path ) unless exists $self->{ruleset}{$path}{rules};

        ## <exclusion/>
          my $exclude = 0;
          foreach my $exclusion ( @{$self->{ruleset}{$path}{x}} ){
             if( $newurl =~ $exclusion ){
                $exclude = 1;
                last;
             }
          }
          next if $exclude;

        ## <rule/>
          foreach my $rule ( @{$self->{ruleset}{$path}{rules}} ){
             my @match = $newurl =~ $rule->{from};
             if( @match ){
                $newurl =~ s/$rule->{from}/$rule->{to}/;

                my $n = 0;
                foreach my $bit ( @match ){
                   ++$n; $bit = "" unless defined $bit;
                   $newurl =~ s/\$$n/$bit/gsm;
                }

                return $newurl;
             }
          }
     }

   ## Didn't match anything. Return the original rule
     return $url;
}

sub read {
   my $self = shift;
   my @paths = int(@_) ? @_ : @{$self->{paths}};

   $self->{ruleset}{$_}{check}=1 foreach keys %{$self->{ruleset}};

   $self->_read($_) foreach @paths;

   foreach( keys %{$self->{ruleset}} ){
      delete $self->{ruleset}{$_} if $self->{ruleset}{$_}{check};
   }
}

## Reads in all of the rulesets. Uses pattern matching rather than LibXML
#  for performance reasons and only pulls out the name, target and default_off
#  values. _full_parse handles the rest, the first time a target is matched.
#
sub _read {
   my( $self, $path ) = @_;

   $path =~ s/\/+$//;

   opendir( my $dir, $path ) or die $!;
   foreach( readdir $dir ){
      my $file = $_;
      next unless $file =~ /\.xml$/;

      ## Last modified time of the ruleset
        my $mtime = (stat("$path/$file"))[9];
        if( exists $self->{ruleset}{"$path/$file"}{m} && $mtime == $self->{ruleset}{"$path/$file"}{m} ){
           delete $self->{ruleset}{"$path/$file"}{check};
           next;
        }

      ## Read the raw file
        my $raw;
        {
           open my $in, '<', "$path/$file" or die $!;
           local $/ = undef;
           $raw = <$in>;
           close $in;
        }

      ## Parse out the ruleset name and default_off values
        my( $name, $default_off );
	{
           my( $ruleset ) = $raw =~ /<ruleset\s+([^>]+?)[\s\/]*>/s;
	   my %attr;
	   $ruleset =~ s/\s*([^\s"]+)\s*=\s*"([^"]+)"\s*/$attr{lc($1)}=$2/eg;
           $name = $attr{'name'};
	   $default_off = $attr{'default_off'};
        }
        next if defined $default_off && !$self->{enable_default_off_rulesets};

      ## Parse out the targets
        my @targets;
	{
	   my $buf = $raw;
           $buf =~ s/<target\s[^>]*?host="([^"]+)"/push @targets,lc($1)/eg;
	   @targets = map { [split(/\./,$_)] } @targets;
	}

      ## Add/update the ruleset in memory
        $self->{ruleset}{"$path/$file"} = {
           t => \@targets,
	   m => $mtime,
        };
   }
   closedir $dir;
}

sub _full_parse {
   my( $self, $path ) = @_;

   my $doc = XML::LibXML->load_xml( location => $path ) or die $!;
   my $xml = $doc->documentElement;

   my @exclusions;
   foreach my $exclusion ( $xml->findnodes('/ruleset/exclusion') ){
      my $pattern = $exclusion->getAttribute('pattern');
      push @exclusions, qr{$pattern}i;
   }

   my @rules;
   foreach my $rule ( $xml->findnodes('/ruleset/rule') ){
      my $from = $rule->getAttribute('from');
      push @rules, {
         from => qr{$from}i,
         to   => $rule->getAttribute('to'),
      };
   }

   $self->{ruleset}{$path}{x}     = \@exclusions;
   $self->{ruleset}{$path}{rules} = \@rules;
}

1;

__END__

=pod

=head1 NAME

HTTPSEverywhere -- Use the rulesets generated for HTTPS-Everywhere from
Perl.

=head1 DESCRIPTION

HTTPS Everywhere is a Firefox addon which forces users to use https for
certain websites. This Perl module was written to take advantage of the
rulesets generated for that project. You need to download the rules
separately.

Project page:

  https://www.eff.org/https-everywhere

Obtain the repository and rules from Git:

  git clone git://git.torproject.org/https-everywhere.git

This project is currently under heavy development and the format of
the rulesets are likely to change. This module may stop working
because of that. I will endeavour to keep it up to date with the
latest ruleset format.

=head1 EXAMPLES

  my $he = new HTTPSEverywhere(
     rulesets => [
        '/git/https-everywhere/src/chrome/content/rules',
     ],
  );
  my $url = $he->convert('http://gmail.com/foo');

  In this example, $url would contain https://mail.google.com/foo

=head1 METHODS

=over

=item B<new( rulesets => \@paths, enable_default_off_rulesets => 0 ))>

  "rulesets" contains a list of paths to the directory or directories
  containing the xml ruleset files

  "enable_default_off_rulesets" turns on the rulesets which are marked
  as "default_off". It takes a true/false (1/0) value. By default it
  is disabled.

=item B<read( @paths )>

  Clears out the known rulesets and reads them from each of the
  directories in @paths. If @paths is not provided, it re-reads
  them from the paths specified in new().

=item B<convert( $url )>

  Returns the converted version of the URL. If no rules match the
  URL, the original URL is returned.

=back

=head1 COPYRIGHT

Copyright (c) 2010  Mike Cardwell

=head1 LICENSE

Licensed under the GNU General Public License. See
http://www.opensource.org/licenses/gpl-2.0.php

=head1 AUTHOR

Mike Cardwell - https://grepular.com/ 

Copyright (C) 2010  Mike Cardwell

=cut
