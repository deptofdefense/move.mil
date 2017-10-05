class OfficesController < ApplicationController
  def index
    return unless search
    return @error_message = search.error_message unless search.valid?

    @transportation_offices = TransportationOffice.by_distance_with_shipping_office(search.result).paginate(page: params[:page])
  end

  private

  def search
    @search ||= coordinates_search || zip_code_search || nil
  end

  def coordinates_search
    CoordinatesSearch.new(params) if params[:coordinates].present?
  end

  def zip_code_search
    ZipCodeSearch.new(params) if params[:postal_code].present?
  end
end
