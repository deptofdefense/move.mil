class CustomerServiceController < ApplicationController
  def index
    contacts
  end

  def contacts
    @contacts ||= BranchOfServiceContact.all
  end

end
