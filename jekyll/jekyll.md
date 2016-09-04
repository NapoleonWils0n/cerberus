# jekyll install

## ruby install
sudo pacman -S ruby

Before you use RubyGems, you should add $(ruby -e "print Gem.user_dir")/bin to your $PATH.
You can do this by adding the following line to ~/.bashrc:

```
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
```

* Before installing Jekyll make sure to update RubyGems.

```
gem update
```

* Then install bundler

```
gem install bundler
```

* install jekyll

```
gem install jekyll
```


### Markdown

You can install RDiscount with Rubygems as root or through ruby-rdiscount package.


#### ruby gems

```
sudo gem install rdiscount -s http://gemcutter.org
```

* Then add the following line to your _config.yml.

```
markdown: rdiscount
```

#### pacman

```
sudo pacman -S ruby-rdiscount 
```

### create new jekyll project


```
jekyll new project
```

change directory in the new project and run bundle install

```
cd project
```


* bundle install

```
bundle install 
```
