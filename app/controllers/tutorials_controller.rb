class TutorialsController < ApplicationController
  def index
    tutorials
  end

  private

  def tutorials
    @tutorials ||= Tutorial.all
  end
end
