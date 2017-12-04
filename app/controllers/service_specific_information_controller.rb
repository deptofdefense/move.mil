class ServiceSpecificInformationController < ApplicationController
  def show
    @branch = BranchOfService.includes(:service_specific_posts, :branch_of_service_contact).find(params[:id] || 'army')
    @branches = BranchOfService.all
  end
end
