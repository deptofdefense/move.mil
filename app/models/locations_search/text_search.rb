module LocationsSearch
  class TextSearch
    include Geokit::Geocoders

    def initialize(params)
      @params = params
    end

    def error_message
      'There was a problem performing that search. Mind trying again?'
    end

    def result
      {
        latitude: location.latitude,
        longitude: location.longitude
      }
    end

    def valid?
      search_params.permitted? && location.success
    end

    private

    def location
      @location ||= GoogleGeocoder.geocode(search_params[:query])
    end

    def search_params
      @search_params ||= @params.permit(:query)
    end
  end
end
