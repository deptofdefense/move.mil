class TutorialsController < ApplicationController
  def index
    tutorials
  end

  def show
    tutorial
  end

  private

  def tutorial
    @tutorial ||= Tutorial.find(params[:id])
  end

  def tutorials
    @tutorials ||= Tutorial.all
  end
end
