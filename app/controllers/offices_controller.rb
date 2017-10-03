class OfficesController < ApplicationController
  def index
    return unless search
    return @error_message = search.error_message unless search.valid?

    @transportation_offices = TransportationOffice.by_distance_with_shipping_office(search.result).paginate(page: params[:page])
  end

  private

  def search
    @search ||=
      if params[:coordinates].present?
        coordinates_search
      elsif params[:postal_code].present?
        zip_code_search
      end
  end

  def coordinates_search
    @coordinates_search ||= CoordinatesSearch.new(params)
  end

  def zip_code_search
    @zip_code_search ||= ZipCodeSearch.new(params)
  end
end
