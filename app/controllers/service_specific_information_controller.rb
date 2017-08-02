class ServiceSpecificInformationController < ApplicationController
  def index
    posts
  end

  private

  def posts
    @posts_army ||= ServiceSpecificPost.where(branch: 'army').order(:effective_at).reverse_order
    @posts_air_force ||= ServiceSpecificPost.where(branch: 'air_force').order(:effective_at).reverse_order
    @posts_marine_corps ||= ServiceSpecificPost.where(branch: 'marine_corps').order(:effective_at).reverse_order
    @posts_navy ||= ServiceSpecificPost.where(branch: 'navy').order(:effective_at).reverse_order
    @posts_coast_guard ||= ServiceSpecificPost.where(branch: 'coast_guard').order(:effective_at).reverse_order
  end
end
