class ServiceSpecificInformationController < ApplicationController
<<<<<<< HEAD
  def index; end
=======
  def index
    case params[:branch]
    when 'air-force'
      @posts = ServiceSpecificPost.where(branch: 'air_force')
      @contact = BranchOfServiceContact.find_by(branch: 'Air Force')
      render 'air-force'
    when 'marine-corps'
      @posts = ServiceSpecificPost.where(branch: 'marine_corps')
      @contact = BranchOfServiceContact.find_by(branch: 'Marine Corps')
      render 'marine-corps'
    when 'navy'
      @posts = ServiceSpecificPost.where(branch: 'navy')
      @contact = BranchOfServiceContact.find_by(branch: 'Navy')
      render 'navy'
    when 'coast-guard'
      @posts = ServiceSpecificPost.where(branch: 'coast_guard')
      @contact = BranchOfServiceContact.find_by(branch: 'Coast Guard')
    else
      # Fall back to army
      @posts = ServiceSpecificPost.where(branch: 'army')
      @contact = BranchOfServiceContact.find_by(branch: 'Army')
      render 'army'
    end
  end
>>>>>>> Change routing for service-specific pages
end
