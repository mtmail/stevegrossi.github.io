require 'slim'

###
# Blog settings
###

Time.zone = "Eastern Time (US & Canada)"

activate :blog do |blog|
  blog.name = 'blog'
  # blog.prefix = "blog"
  # blog.permalink = ":year/:month/:day/:title.html"
  blog.sources = "posts/:year-:month-:day-:title.html"
  # blog.taglink = "tags/:tag.html"
  blog.layout = 'blog'
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = ":year.html"
  # blog.month_link = ":year/:month.html"
  # blog.day_link = ":year/:month/:day.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  blog.paginate = true
  blog.per_page = 5
  blog.page_link = "page/:num"
end

activate :blog do |blog|
  blog.name = 'work'
  blog.sources = "work/:year-:month-:day-:title/index.html"
  blog.permalink = "work/:title.html"
end

activate :directory_indexes
activate :meta_tags

page "/feed.xml", layout: false

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", proxy: "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do

  def title_tag
    title = 'work.stevegrossi.com'
    if current_page.try{ |p| p.data.title }
      title = [current_page.data.title, title].join(' | ')
    end
    content_tag(:title, title)
  end

  # Generates an absolute path for a work article's image
  def work_image(article, image, options = {})
    dir = "#{article.date.strftime('%Y-%m-%d')}-#{article.slug}/"
    url = '/work/' + dir + image
    options[:class] = image.split('.').first
    image_tag(url, options)
  end

end

set :css_dir,    'stylesheets'
set :js_dir,     'javascripts'
set :images_dir, 'images'

# Use smart quotes
set :markdown, smartypants: true

# Build-specific configuration
configure :build do

  # Minify HTML
  activate :minify_html

  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Use relative URLs
  activate :relative_assets

  # Add asset fingerprinting to avoid cache issues
  activate :asset_hash, ignore: /work\/|javascripts\/(lang|prett)/

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
