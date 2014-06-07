
# https-everywhere squid set up
#==============================


# Installation instructions:
#
# 1.) In /etc/squid/https-everywhere/ place this file, and HTTPSEverywhere.pm
#
# 2.) Create a directory at /etc/squid3/https-everywhere/git, cd into that directory and do a:
#     git clone git://git.torproject.org/https-everywhere.git
#
# 3.) Edit /etc/squid3/squid.conf and add this line:
#     redirect_program /etc/squid3/https-everywhere/squid.pl

# 3.) make squid.pl executable
sudo chmod +x /etc/squid3/https-everywhere/squid.pl

#
# 5.) Restart squid.
#
# You should cd in to /etc/squid/https-everywhere/git and do a "git pull" on a regular
# basis, to pull down ruleset changes. Cron it if poss