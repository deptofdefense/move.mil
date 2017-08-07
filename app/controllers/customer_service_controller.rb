class CustomerServiceController < ApplicationController
  def index
    contacts
  end

  private
  
  def contacts
    @contacts ||= BranchOfServiceContact.all
  end
end
