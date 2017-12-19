class MetaController < ApplicationController
  def sitemap
    @urls = [root_url, high_voltage_urls, route_urls, service_specific_information_urls, tutorial_urls].flatten.uniq.sort
  end

  private

  def high_voltage_urls
    HighVoltage.page_ids.reject { |page| page == 'homepage' }.map { |page| page_url(page) }
  end

  def route_urls
    %w[customer_service entitlements faqs locations weight_estimator].map { |route| send("#{route}_url") }
  end

  def service_specific_information_urls
    BranchOfService.all.map { |branch| service_specific_information_url(branch) }
  end

  def tutorial_urls
    Tutorial.all.map { |tutorial| tutorial_url(tutorial) }
  end
end
