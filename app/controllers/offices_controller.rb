class OfficesController < ApplicationController
  def index
    return unless search
    return @error_message = search.error_message unless search.valid?

    @result = search.result
    @transportation_offices = TransportationOffice.by_distance_with_shipping_office(latitude: @result[:latitude], longitude: @result[:longitude]).paginate(page: params[:page])
  end

  private

  def search
    return coordinates_search if params[:coordinates].present?
    return zip_code_search if params[:postal_code].present?
  end

  def coordinates_search
    @coordinates_search ||= CoordinatesSearch.new(params)
  end

  def zip_code_search
    @zip_code_search ||= ZipCodeSearch.new(params)
  end
end
