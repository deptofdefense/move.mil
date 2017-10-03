class CoordinatesSearch
  def initialize(params)
    @params = params
  end

  def error_message
    'There was a problem performing that search. Mind trying again?'
  end

  def query
    search_params[:coordinates]
  end

  def result
    coordinates_parts = search_params[:coordinates].split(',')

    {
      latitude: coordinates_parts.first,
      longitude: coordinates_parts.last
    }
  end

  def valid?
    search_params.permitted? && /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/.match?(search_params[:coordinates])
  end

  private

  def search_params
    @search_params ||= @params.permit(:coordinates)
  end
end
