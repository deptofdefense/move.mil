base_url = 'http://www.move.mil'

xml.instruct! :xml, version: '1.0'
xml.urlset 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @pages.each do |page|
    xml.url do
      xml.loc base_url + page
      xml.changefreq 'weekly'
    end
  end

  @branches_of_service.each do |branch|
    xml.url do
      xml.loc base_url + service_specific_information_path(branch)
      xml.changefreq 'weekly'
    end
  end
end
