xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title    'eurucamp Blog'
  xml.subtitle 'european ruby camp | summer edition'
  xml.id   'http://2012.eurucamp.org/'
  xml.link href: 'http://2012.eurucamp.org/'
  xml.link href: 'http://2012.eurucamp.org/feed.xml', rel: 'self'
  xml.updated blog.articles.first.date.to_time.iso8601
  xml.author { xml.name 'eurucamp Team' }

  blog.articles[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => article.url
      xml.id article.url
      xml.published article.date.to_time.iso8601
      xml.updated article.date.to_time.iso8601
      xml.author { xml.name article.data.author.presence || 'eurucamp Team' }
      xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end