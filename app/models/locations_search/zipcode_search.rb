module LocationsSearch
  class ZipcodeSearch
    def initialize(params)
      @params = params
    end

    def error_message
      "There was a problem searching for the ZIP code #{search_params[:query]}. Mind trying again?"
    end

    def query
      "#{zipcode.city}, #{zipcode.state.abbr} #{zipcode.code}"
    end

    def result
      {
        latitude: zipcode.lat,
        longitude: zipcode.lon
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
