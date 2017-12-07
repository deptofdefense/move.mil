class SitemapController < ApplicationController
  def index
    all_urls = [high_voltage_urls, route_urls, service_specific_information_urls, tutorial_urls]

    @url_set = Set.new
    all_urls.each do |urls|
      @url_set.merge(urls)
    end
  end

  def high_voltage_urls
    HighVoltage.page_ids.map { |page| page_url(page) if page != 'homepage' }.compact
  end

  def route_urls
    routes = Rails.application.routes.routes
    paths = routes.map { |route| route.path.spec.to_s[%r{^\/([^\(:*]+)}, 1] }.compact
    paths.map { |path| page_url(path.chomp('/')) unless path.match?(/^(rails|assets|sitemap|homepage|\d)/) }.compact
  end

  def service_specific_information_urls
    BranchOfService.all.map { |branch| service_specific_information_url(branch) }
  end

  def tutorial_urls
    Tutorial.all.map { |tutorial| tutorial_url(tutorial) }
  end
end
