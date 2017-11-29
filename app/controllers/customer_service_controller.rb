class CustomerServiceController < ApplicationController
  def index
    branches
  end

  private

  def branches
    @branches ||= BranchOfService.includes(:branch_of_service_contact).all
  end
end
