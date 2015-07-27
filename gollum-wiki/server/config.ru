__DIR__ = File.expand_path(File.dirname(__FILE__))
$: << __DIR__
require 'rubygems'
require 'yaml'
require 'app'
require "github/markup"

ci = GitHub::Markup::CommandImplementation.new(
    /md|mkdn?|mdwn|mdown|markdown|litcoffee/,
      "pandoc -f markdown-tex_math_dollars-raw_tex")
# Our command needs to go to the front of the queue, in order to take
# precedence before the stock GitHub::Markup::Markdown implementation
GitHub::Markup::markups.unshift(ci)

wiki = Gollum::Wiki.new("/var/wiki/.git")

Gollum::Hook.register(:post_commit, :hook_id) do |committer, sha1|
  committer.wiki.repo.git.pull
  committer.wiki.repo.git.push
end

Gollum::Hook.unregister(:post_commit, :hook_id)


gollum_path = "/var/wiki"
App.set(:gollum_path, gollum_path)
App.set(:authorized_users, YAML.load_file(File.expand_path('users.yml', __DIR__)))
App.set(:default_markup, :markdown)
App.set(:wiki_options, {
:css => true,
:h1_title => true,
:universal_toc => false,
:allow_uploads => true,
:live_preview => true
})
run App