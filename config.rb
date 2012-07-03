require "lib/custom_tag_helpers"
helpers CustomTagHelpers

require 'active_support/core_ext/string'
require 'app/helpers/html5_boilerplate_helper'

###
# Blog settings
###

Middleman::Sitemap::Resource.class_eval do
  def url_without_extension
    ext.blank? ? url : url.sub(/#{ext}$/,'')
  end
end

activate :blog do |blog|
  blog.layout  = "article_layout"
  blog.sources = "blog/:year-:month-:day-:title.html"

  #blog.permalink  = "blog/:year/:month/:day/:title"
  #blog.taglink    = "/blog/tags/:tag"
  #blog.year_link  = "/blog/:year"
  #blog.month_link = "/blog/:year/:month"
  #blog.day_link   = "/blog/:year/:month/:day"
  # blog.summary_length = 250
  # blog.default_extension = ".markdown"
  #blog.tag_template      = "blog/tag"
  #blog.calendar_template = "blog/calendar"
end

page "/feed.xml", :layout => false

###
# Compass
###

# Susy grids in Compass
# First: gem install compass-susy-plugin
# require 'susy'

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates

helpers do
  include Html5BoilerplateHelper
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :cache_buster

  activate :gzip

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
