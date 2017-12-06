class SitemapController < ApplicationController
  def index
    @pages = ['/', '/customer-service', '/entitlements', '/faqs', '/moving-guide/civilians', '/moving-guide/conus', '/moving-guide/nightmare-moves', '/moving-guide/oconus', '/moving-guide/reimbursements', '/moving-guide/retirees-separatees', '/moving-guide/tdy', '/moving-guide/tips', '/resources/inventory-form', '/resources/locator-maps', '/resources/weight-estimator', '/service-specific-information', '/tutorials']

    @branches_of_service = BranchOfService.all

    respond_to do |format|
      format.xml
    end
  end
end
