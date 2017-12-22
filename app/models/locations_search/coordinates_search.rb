module LocationsSearch
  class CoordinatesSearch
    LATITUDE_REGEXP = /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?)$/
    LONGITUDE_REGEXP = /^[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/

    def initialize(params)
      @params = params
    end

    def error_message
      'There was a problem performing that search. Mind trying again?'
    end

    def query
      search_params.values.join(', ')
    end

    def result
      {
        latitude: search_params[:latitude],
        longitude: search_params[:longitude]
      }
    end

    def valid?
      search_params.permitted? && LATITUDE_REGEXP.match?(search_params[:latitude]) && LONGITUDE_REGEXP.match?(search_params[:longitude])
    end

    private

    def search_params
      @search_params ||= @params.permit(:latitude, :longitude)
    end
  end
end
