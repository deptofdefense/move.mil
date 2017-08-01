class ServiceSpecificInformationController < ApplicationController
  def index
    posts
  end

  private

  def posts
    @posts_army ||= ServiceSpecificPost.where(branch: 'army').order(:effective)
    @posts_air_force ||= ServiceSpecificPost.where(branch: 'air_force').order(:effective)
    @posts_marine_corps ||= ServiceSpecificPost.where(branch: 'marine_corps').order(:effective)
    @posts_navy ||= ServiceSpecificPost.where(branch: 'navy').order(:effective)
    @posts_coast_guard ||= ServiceSpecificPost.where(branch: 'coast_guard').order(:effective)
  end
end
