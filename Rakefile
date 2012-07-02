require 'bundler/setup'
require 'heroku_san'

config_file = File.join(File.expand_path(File.dirname(__FILE__)), 'config', 'heroku.yml')
HerokuSan.project = HerokuSan::Project.new(config_file, :deploy => HerokuSan::Deploy::Sinatra)

load 'heroku_san/tasks.rb'

require 'nokogiri'
require 'open-uri'
require 'yaml'

namespace :utils do

  desc "Update attendees list with data from Lanyrd.com"
  task :update_attendees do
    data = lanyrd_attendees.to_yaml
    File.open('data/attendees.yml', 'w') {|f| f.write(data) }
  end

  # scrapes eurucamp page on lanyrd.com and returns
  # array of Twitter names
  def lanyrd_attendees
    url = 'http://lanyrd.com/2012/eurucamp/'
    sel = '.attendees-placeholder ul li a'
    doc = Nokogiri::HTML(open(url))
    doc.css(sel).map { |a| a[:title].match('@(.*)')[1] }
  end
end
