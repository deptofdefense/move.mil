class LocatorMapsController < ApplicationController
  def index
    # center the map by default on the rough middle of CONUS
    @origin = [38.0, -97.0]
    @offices = []
    @offset = params[:offset].present? ? params[:offset].to_i : 0
    if @offset < 0
      @offset = 0
    end

    if params[:zipcode].present?
      if params[:zipcode].match('\d{5}') != nil
        search_zipcode
      end
    elsif params[:coords].present?
      coords = params[:coords].split(',')
      if coords.length == 2
        search_coords(coords)
      end
    end
  end

  def search_coords(coords)
    @offices = TransportationOffice.limit(5).offset(@offset).by_distance(origin: coords)
    @origin = coords
  end

  def search_zipcode
    zipcode = ZipCodeTabulationArea.find_by(zipcode: params[:zipcode])
    if zipcode == nil
      return
    end
    search_coords([zipcode.lat, zipcode.lng])
  end
end
