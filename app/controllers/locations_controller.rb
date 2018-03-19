class LocationsController < ApplicationController
  def index
    # return on direct requests to the page
    return unless search

    # return error message on invalid search
    return error_message unless search.valid?

    # return search results on valid search (GET)
    return locations unless request.post?

    # redirect on valid search (POST)
    redirect_to locations_path(search.result)
  end

  private

  def coordinates_search
    LocationsSearch::CoordinatesSearch.new(params) if params[:latitude].present? && params[:longitude].present?
  end

  def error_message
    @error_message ||= search.error_message
  end

  def locations
    @locations ||= Location.transportation_offices_and_weight_scales_by_distance(search.result).paginate(page: params[:page])
  end

  def search
    @search ||= coordinates_search || zipcode_search || text_search || nil
  end

  def text_search
    LocationsSearch::TextSearch.new(params) if params[:query].present?
  end

  def zipcode_search
    LocationsSearch::ZipcodeSearch.new(params) if params[:query].present? && /^\d{5}$/ === params[:query]
  end
end
