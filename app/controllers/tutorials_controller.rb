class TutorialsController < ApplicationController
  def show
    return @tutorial = tutorials.first unless params[:id]

    @tutorial = tutorials.find { |tutorial| tutorial.slug == params[:id] }

    # Redirect on invalid / outdated tutorial ID
    redirect_to tutorial_path if @tutorial.nil?
  end

  def tutorials
    @tutorials ||= Tutorial.includes(:tutorial_steps).all
  end
end
