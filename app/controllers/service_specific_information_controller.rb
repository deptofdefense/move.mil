class ServiceSpecificInformationController < ApplicationController
  def show
    branch_id = params[:id] || 'army'
    @branch = BranchOfService.includes(:service_specific_posts, :branch_of_service_contact).find(branch_id)
    @branches = BranchOfService.all
    render branch_id
  end
end
