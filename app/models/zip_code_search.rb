class ZipCodeSearch
  def initialize(params)
    @params = params
  end

  def error_message
    'There was a problem locating that ZIP Code. Mind trying your search again?'
  end

  def query
    search_params[:query].rjust(5, '0')
  end

  def result
    {
      latitude: zip_code_tabulation_area.latitude,
      longitude: zip_code_tabulation_area.longitude
    }
  end

  def valid?
    search_params.permitted? && /^\d{5}$/.match?(search_params[:query]) && zip_code_tabulation_area
  end

  private

  def search_params
    @search_params ||= @params.permit(:query)
  end

  def zip_code_tabulation_area
    @zip_code_tabulation_area ||= ZipCodeTabulationArea.find_by(zip_code: search_params[:query])
  end
end
