class ServiceSpecificInformationController < ApplicationController
<<<<<<< HEAD
  def index; end
=======
  def index
    case params[:branch]
    when 'air-force'
      @posts = ServiceSpecificPost.where(branch: 'air_force')
      render 'air-force'
    when 'marine-corps'
      @posts = ServiceSpecificPost.where(branch: 'marine_corps')
      render 'marine-corps'
    when 'navy'
      @posts = ServiceSpecificPost.where(branch: 'navy')
      render 'navy'
    when 'coast-guard'
      @posts = ServiceSpecificPost.where(branch: 'coast_guard')
    else
      # Fall back to army
      @posts = ServiceSpecificPost.where(branch: 'army')
      render 'army'
    end
  end
>>>>>>> Change routing for service-specific pages
end
