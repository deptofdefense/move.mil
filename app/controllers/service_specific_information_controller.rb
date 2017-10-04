class ServiceSpecificInformationController < ApplicationController
  def index
    grouped_posts = ServiceSpecificPost.all.group_by(&:branch)

    @army_posts = grouped_posts['army']
    @air_force_posts = grouped_posts['air_force']
    @navy_posts = grouped_posts['navy']
    @marine_corps_posts = grouped_posts['marine_corps']
    @coast_guard_posts = grouped_posts['coast_guard']
  end
end
