class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.includes(:tutorial_steps).all
  end

  def show
    @tutorial = Tutorial.includes(:tutorial_steps).find(params[:id])
  end
end
