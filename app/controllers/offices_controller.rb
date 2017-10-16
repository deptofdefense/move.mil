class OfficesController < ApplicationController
  def index
    return unless search
    return @error_message = search.error_message unless search.valid?
    return redirect_to offices_path(search.result) if request.post?

    @transportation_offices = TransportationOffice.by_distance_with_shipping_office(search.result).paginate(page: params[:page])
  end

  private

  def coordinates_search
    CoordinatesSearch.new(params) if params[:latitude].present? && params[:longitude].present?
  end

  def installation_search
    InstallationSearch.new(params) if params[:query].present?
  end

  def search
    @search ||= coordinates_search || zip_code_search || installation_search || nil
  end

  def zip_code_search
    ZipCodeSearch.new(params) if params[:query].present? && /^\d{5}$/.match?(params[:query])
  end
end
