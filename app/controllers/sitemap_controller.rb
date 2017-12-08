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
    %w[entitlements customer-service faqs resources/locator-maps resources/weight-estimator].map { |page| page_url(page) }
  end

  def service_specific_information_urls
    BranchOfService.all.map { |branch| service_specific_information_url(branch) }
  end

  def tutorial_urls
    Tutorial.all.map { |tutorial| tutorial_url(tutorial) }
  end
end
