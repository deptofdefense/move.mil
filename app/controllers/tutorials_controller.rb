class TutorialsController < ApplicationController
  def show
    @tutorials = Tutorial.includes(:tutorial_steps).all
    @tutorial = params[:id] ? @tutorials.find { |tutorial| tutorial.slug == params[:id] } : @tutorials.first
  end
end
