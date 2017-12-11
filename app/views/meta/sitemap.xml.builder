xml.instruct! :xml, version: 1.0

xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @urls.each do |url|
    xml.url do
      xml.loc url
      xml.changefreq 'weekly'
    end
  end
end
