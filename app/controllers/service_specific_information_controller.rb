class ServiceSpecificInformationController < ApplicationController
  def index
    posts_army
    posts_air_force
    posts_navy
    posts_marine_corps
    posts_coast_guard
  end

  private

  def posts_army
    @posts_army ||= ServiceSpecificPost.posts_army
  end

  def posts_air_force
    @posts_air_force ||= ServiceSpecificPost.posts_air_force
  end

  def posts_navy
    @posts_navy ||= ServiceSpecificPost.posts_navy
  end

  def posts_marine_corps
    @posts_marine_corps ||= ServiceSpecificPost.posts_marine_corps
  end

  def posts_coast_guard
    @posts_coast_guard ||= ServiceSpecificPost.posts_coast_guard
  end
end
