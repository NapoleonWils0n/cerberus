# Gollum wiki Docker

## Dockerfile

* Gollum Dockerfile

```
# gollum wiki server

FROM ubuntu:16.10
MAINTAINER NapoleonWilson <danieljwilcox@gmail.com>

# Install dependencies
# RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install -q build-essential \
make ruby ruby-dev bundler python2.7 libicu-dev libreadline-dev libssl-dev zlib1g-dev git \
pandoc pandoc-citeproc

# Install gollum
RUN gem install gollum redcarpet github-markdown --no-ri --no-rdoc

# Initialize wiki data
RUN mkdir /var/wiki

# Expose default gollum port 4567
EXPOSE 4567

# back up file
RUN mv /var/lib/gems/2.3.0/gems/gollum-lib-4.2.2/lib/gollum-lib/sanitization.rb /var/lib/gems/2.3.0/gems/gollum-lib-4.2.2/lib/gollum-lib/sanitization.rb.bak

# add custom html santizer options
ADD sanitization.rb /var/lib/gems/2.3.0/gems/gollum-lib-4.2.2/lib/gollum-lib/sanitization.rb

CMD ["rackup", "-p", "4567", "-o", "0.0.0.0", "/var/wiki/config.ru"]
```

### sanitazation.rb file

* sanitazation.rb must be in the same directory as the Dockerfile

```
# ~*~ encoding: utf-8 ~*~
module Gollum
  # Encapsulate sanitization options.
  #
  # This class does not yet support all options of Sanitize library.
  # See http://github.com/rgrove/sanitize/.
  class Sanitization
    # Default whitelisted elements.
    ELEMENTS   = [
        'a', 'abbr', 'acronym', 'address', 'area', 'b', 'big',
        'blockquote', 'br', 'button', 'caption', 'center', 'cite',
        'code', 'col', 'colgroup', 'dd', 'del', 'dfn', 'dir',
        'div', 'dl', 'dt', 'em', 'fieldset', 'font', 'form', 'h1',
        'h2', 'h3', 'h4', 'h5', 'h6', 'hr', 'i', 'iframe', 'img', 'input',
        'ins', 'kbd', 'label', 'legend', 'li', 'map', 'menu',
        'ol', 'optgroup', 'option', 'p', 'pre', 'q', 's', 'samp',
        'select', 'small', 'span', 'strike', 'strong', 'sub',
        'sup', 'table', 'tbody', 'td', 'textarea', 'tfoot', 'th',
        'thead', 'tr', 'tt', 'u', 'ul', 'var'
    ].freeze

    # Default whitelisted attributes.
    ATTRIBUTES = {
        'a'   => ['href'],
        'img' => ['src'],
        'iframe' => ['src', 'width', 'height', 'frameborder', 'allowfullscreen'],
        :all  => ['abbr', 'accept', 'accept-charset',
                  'accesskey', 'action', 'align', 'alt', 'axis',
                  'border', 'cellpadding', 'cellspacing', 'char',
                  'charoff', 'class', 'charset', 'checked', 'cite',
                  'clear', 'cols', 'colspan', 'color',
                  'compact', 'coords', 'datetime', 'dir',
                  'disabled', 'enctype', 'for', 'frame',
                  'headers', 'height', 'hreflang',
                  'hspace', 'id', 'ismap', 'label', 'lang',
                  'longdesc', 'maxlength', 'media', 'method',
                  'multiple', 'name', 'nohref', 'noshade',
                  'nowrap', 'prompt', 'readonly', 'rel', 'rev',
                  'rows', 'rowspan', 'rules', 'scope',
                  'selected', 'shape', 'size', 'span',
                  'start', 'summary', 'tabindex', 'target',
                  'title', 'type', 'usemap', 'valign', 'value',
                  'vspace', 'width']
    }.freeze

    # Default whitelisted protocols for URLs.
    PROTOCOLS  = {
        'a'    => { 'href' => ['http', 'https', 'mailto', 'ftp', 'irc', 'apt', :relative] },
        'img'  => { 'src' => ['http', 'https', :relative] },
        'iframe'  => { 'src' => ['http', 'https'] },
        'form' => { 'action' => ['http', 'https', :relative] }
    }.freeze

    ADD_ATTRIBUTES  = lambda do |env, node|
      if add = env[:config][:add_attributes][node.name]
        add.each do |key, value|
          node[key] = value
        end
      end
    end

    # Default elements whose contents will be removed in addition
    # to the elements themselve
    REMOVE_CONTENTS = [
        'script',
        'style'
    ].freeze

    # Default transformers to force @id attributes with 'wiki-' prefix
    TRANSFORMERS    = [
        lambda do |env|
          node = env[:node]
          return if env[:is_whitelisted] || !node.element?
          prefix      = env[:config][:id_prefix]
          found_attrs = %w(id name).select do |key|
            if value = node[key]
              node[key] = value.gsub(/\A(#{prefix})?/, prefix)
            end
          end
          if found_attrs.size > 0
            ADD_ATTRIBUTES.call(env, node)
            {}
          end
        end,
        lambda do |env|
          node = env[:node]
          return unless value = node['href']
          prefix       = env[:config][:id_prefix]
          node['href'] = value.gsub(/\A\#(#{prefix})?/, '#'+prefix)
          ADD_ATTRIBUTES.call(env, node)
          {}
        end
    ].freeze

    # Gets an Array of whitelisted HTML elements.  Default: ELEMENTS.
    attr_reader :elements

    # Gets a Hash describing which attributes are allowed in which HTML
    # elements.  Default: ATTRIBUTES.
    attr_reader :attributes

    # Gets a Hash describing which URI protocols are allowed in HTML
    # attributes.  Default: PROTOCOLS
    attr_reader :protocols

    # Gets a Hash describing which URI protocols are allowed in HTML
    # attributes.  Default: TRANSFORMERS
    attr_reader :transformers

    # Gets or sets a String prefix which is added to ID attributes.
    # Default: ''
    attr_accessor :id_prefix

    # Gets a Hash describing HTML attributes that Sanitize should add.
    # Default: {}
    attr_reader :add_attributes

    # Gets an Array of element names whose contents will be removed in addition
    # to the elements themselves. Default: REMOVE_CONTENTS
    attr_reader :remove_contents

    # Sets a boolean determining whether Sanitize allows HTML comments in the
    # output.  Default: false.
    attr_writer :allow_comments

    def initialize
      @elements        = ELEMENTS.dup
      @attributes      = ATTRIBUTES.dup
      @protocols       = PROTOCOLS.dup
      @transformers    = TRANSFORMERS.dup
      @add_attributes  = {}
      @remove_contents = REMOVE_CONTENTS.dup
      @allow_comments  = false
      @id_prefix       = ''
      yield self if block_given?
    end

    # Determines if Sanitize should allow HTML comments.
    #
    # Returns True if comments are allowed, or False.
    def allow_comments?
      !!@allow_comments
    end

    # Modifies the current Sanitization instance to sanitize older revisions
    # of pages.
    #
    # Returns a Sanitization instance.
    def history_sanitization
      self.class.new do |sanitize|
        sanitize.add_attributes['a'] = { 'rel' => 'nofollow' }
      end
    end

    # Builds a Hash of options suitable for Sanitize.clean.
    #
    # Returns a Hash.
    def to_hash
      { :elements        => elements,
        :attributes      => attributes,
        :protocols       => protocols,
        :add_attributes  => add_attributes,
        :remove_contents => remove_contents,
        :allow_comments  => allow_comments?,
        :transformers    => transformers,
        :id_prefix       => id_prefix
      }
    end

    # Builds a Sanitize instance from the current options.
    #
    # Returns a Sanitize instance.
    def to_sanitize
      Sanitize.new(to_hash)
    end
  end
end
```

### Build the Dockerfile

```
docker build -t="napoleonwilson/gollum-wiki:v1" .
```

### Run the gollum docker container

```
docker run --name gollum-wiki-port -d -p 0.0.0.0:4567:4567 -v /var/wiki:/var/wiki napoleonwilson/gollum-wiki:v1
```

## create the directories for git and the wiki on the server

* create the wiki directory

```
mkdir -p /var/wiki
```

* create the git directory

```
mkdir -p /home/git
```

## create ~/.ssh/config on your local computer

Edit your ssh config file

```
vim ~/.ssh/config
```

```
# gollum-ubuntu 
Host gollum-wiki
User root
Port 22
HostName 123.11.22.111
```

## create local git repository

* create the wiki directory on local computer

```
mkdir -p ~/wiki
```

* change directory in wiki directory

```
cd ~/wiki
```

* initalize the git repository

```
git init .
```

* add all the file to git

```
git add .
```

* git commit the files and add commit message

```
git commit -a
```

### create users and passwords

* create sha1 hash of password

```
	echo -n yourpassword | sha1sum | awk '{print $1}'
```

* sha1 version of yourpassword

```
e4fcf0149weqhw12754db05ebcdb012fed265bxd84
```

### users.yml file

* users.yml file with users and passwords

```
---
- - John Doe
  - johndoe@gmail.com 
  - e4fcf0149weqhw12754db05ebcdb012fed265bxd84
```

### config.ru

```
#!/usr/bin/env ruby

__DIR__ = File.expand_path(File.dirname(__FILE__))
$: << __DIR__
require 'rubygems'
require 'yaml'
require 'gollum/app'
require 'app'
require "github/markup"

wiki = Gollum::Wiki.new("/var/wiki/.git")

Gollum::Hook.register(:post_commit, :hook_id) do |committer, sha1|
  wiki.repo.git.pull("origin", "master")
  wiki.repo.git.push("origin", "master")
end

Gollum::Hook.unregister(:post_commit, :hook_id)


gollum_path = "/var/wiki"
Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:authorized_users, YAML.load_file(File.expand_path('users.yml', __DIR__)))
Precious::App.set(:default_markup, :markdown)
Precious::App.set(:wiki_options, {
:css => true,
:h1_title => true,
:universal_toc => false,
:allow_uploads => true,
:live_preview => true
})
run App
```
### app.rb

```
require 'gollum/app'
require 'digest/sha1'

class App < Precious::App
  User = Struct.new(:name, :email, :password_hash)

  before /^\/(edit|create|delete|livepreview|revert)/ do authenticate! ; end

  helpers do
    def authenticate!
      @_auth ||=  Rack::Auth::Basic::Request.new(request.env)
      if @_auth.provided?
      end
      if @_auth.provided? && @_auth.basic? && @_auth.credentials &&
        @user = detected_user(@_auth.credentials)
        return @user
      else
        response['WWW-Authenticate'] = %(Basic realm="Gollum Wiki")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def users
      @_users ||= settings.authorized_users.map {|u| User.new(*u) }
    end

    def detected_user(credentials)
      users.detect do |u|
        [u.email, u.password_hash] ==
        [credentials[0], Digest::SHA1.hexdigest(credentials[1])]
      end
    end
  end

  def commit_message
    {
      :message => params[:message],
      :name => @user.name,
      :email => @user.email
    }
  end
end
```

### custom.css

* custom css file for the wiki

```
iframe {
max-width: 100%;
}

/* hide buttons */
.minibutton a.action-page-history,
.minibutton a.action-all-pages,
.minibutton a.action-fileview { display: none; }


ul.actions li:nth-child(3),
ul.actions li:nth-child(4)
{ margin-left: 0; }

/* hide last edit
#footer p#last-edit { display: none; }
.page #footer { border-top: 0px; }
```

## clone the local git repository

* clone the git repository

```
git clone --bare ~/wiki ~/Desktop/wiki.git
```

* scp git repo to server

```
scp -r ~/Desktop/wiki.git gollum-wiki:/home/git/wiki.git
```

* add remote location to local git working copy

```
git remote add origin gollum-wiki:/home/git/wiki.git
```

* push local copy your remote, with -u for first push

```
git push -u origin master
```

* push local copy your remote

```
git push origin master
```

## run docker-registry

## create reverse ssh tunnel

* ssh tunnel to docker registry using ssh config, replace docker with server name

```
ssh -R 5000:localhost:5000 docker
```

* if you dont want to use a ssh config file you can also specify the user and server

* ssh tunnel to docker registry

```
ssh -R 5000:localhost:5000 user@server-ip-address
```

## pull image over ssh tunnel and docker-registry

```
docker pull localhost:5000/gollum-wiki:v1
```

## run gollum

* kill any running instances of gollum

```
ps -ef | grep rackup | grep -v grep | awk '{print $2}' | xargs kill -9
```

* run gollum in the background

```
nohup rackup -p 4567 /var/wiki/config.ru > /dev/null &
```

### nginx server

```
sudo vim /etc/nginx/nginx.conf
```

* start nginx

```
user www-data;
worker_processes 4;
pid /run/nginx.pid;

events {
        worker_connections 768;
        # multi_accept on;
}

http {

    sendfile on;

    gzip              on;
    gzip_http_version 1.0;
    gzip_proxied      any;
    gzip_min_length   500;
    gzip_disable      "MSIE [1-6]\.";
    gzip_types        text/plain text/xml text/css
                      text/comma-separated-values
                      text/javascript
                      application/x-javascript
                      application/atom+xml;

    # List of application servers
    upstream app_servers {

        server 127.0.0.1:4567;

    }
   # Configuration for the server
    server {

        # Running port
        listen 80;

        # Proxying the connections connections
        location / {
            proxy_pass         http://app_servers;
            proxy_redirect     off;
            proxy_set_header   Host $host;
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Host $server_name;
        }
    }
}
```

* ufw firewall for port 80

list the apps

```
ufw app list
```

* allow nginx

```
ufw allow 'Nginx HTTP'
```

* start nginx

```
sudo systemctl start nginx
```

