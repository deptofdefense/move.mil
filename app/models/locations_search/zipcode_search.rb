module LocationsSearch
  class ZipcodeSearch

    def initialize(params)
      @params = params
    end

    def error_message
      'There was a problem performing that search. Mind trying again?'
    end

    def result
      {
        latitude: zipcode.lat,
        longitude: zipcode.lon,
        city: zipcode.city,
        state: zipcode.state
      }
    end

    def valid?
      search_params.permitted? && !zipcode.nil?
    end

    private

    def zipcode
      @zipcode ||= Zipcode.find_by(code: search_params[:query])
    end

    def search_params
      @search_params ||= @params.permit(:query)
    end
  end
end
