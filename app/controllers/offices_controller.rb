class OfficesController < ApplicationController
  def index
    return unless params[:postal_code]
    return error_message unless zip_code_search.valid? && zip_code

    @transportation_offices = TransportationOffice.includes(:shipping_office).by_distance(origin: [zip_code.latitude, zip_code.longitude]).paginate(page: params[:page])
  end

  private

  def error_message
    @error_message ||= 'There was a problem locating that ZIP Code. Mind trying your search again?'
  end

  def zip_code
    @zip_code ||= zip_code_search.result
  end

  def zip_code_search
    @zip_code_search ||= ZipCodeSearch.new(params)
  end
end
