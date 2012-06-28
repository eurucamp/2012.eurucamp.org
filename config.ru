#!/usr/bin/env rackup
# encoding: utf-8

require 'rack/rewrite'
require 'rack/contrib/try_static'

use Rack::Rewrite do
  # ie:
  # HOST_EURUCAMP=lvh.me HOST_JRUBYCONF=jruby.lvh.me bundle exec rackup
  rewrite %r{(.*)}, '/eurucamp/$1',  host: (ENV['HOST_EURUCAMP']  || '2012.eurucamp.eu')
  rewrite %r{(.*)}, '/jrubyconf/$1', host: (ENV['HOST_JRUBYCONF'] || 'jrubyconf.eu')
end
use Rack::TryStatic, :root => "build", :urls => %w[/], :try => ['.html', 'index.html', '/index.html']

# Run your own Rack app here or use this one to serve 404 messages:
run lambda{ |env|
  not_found_page = File.expand_path("../build/404.html", __FILE__)
  if File.exist?(not_found_page)
    [ 404, { 'Content-Type'  => 'text/html'}, [File.read(not_found_page)] ]
  else
    [ 404, { 'Content-Type'  => 'text/html' }, ['404 - page not found'] ]
  end
}