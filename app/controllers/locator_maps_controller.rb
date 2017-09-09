class LocatorMapsController < ApplicationController
  def index
    # center the map by default on the rough middle of CONUS
    @origin = [38.0, -97.0]
    @offices = []

    offset

    return unless params[:zipcode].present? || params[:coords].present?
    return search_zipcode unless params[:zipcode].match(/\d{5}/).nil?
    return if params[:coords].blank?

    coords = params[:coords].tr(' ', '').split(',')
    search_coords(coords) if coords.length == 2
  end

  private

  def offset
    @offset ||= params[:offset].present? && params[:offset].to_i.positive? ? params[:offset].to_i : 0
  end

  def search_coords(coords)
    @offices = TransportationOffice.limit(5).offset(@offset).by_distance(origin: coords)
    @origin = coords
  end

  def search_zipcode
    search_coords([zipcode.lat, zipcode.lng]) unless zipcode.nil?
  end

  def zipcode
    @zipcode ||= ZipCodeTabulationArea.find_by(zipcode: params[:zipcode])
  end
end
