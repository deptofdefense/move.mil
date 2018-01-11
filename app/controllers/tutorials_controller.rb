class TutorialsController < ApplicationController
  def show
    @tutorials = Tutorial.includes(:tutorial_steps).all.to_a
    if params[:id]
      @tutorial = @tutorials.find { |tutorial| tutorial.slug == params[:id] }
      return unless @tutorial.nil?

      # Redirect to /tutorials on invalid / outdated tutorial ID
      redirect_to tutorial_path
    else
      @tutorial = @tutorials.first
    end
  end
end
