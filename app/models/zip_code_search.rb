class ZipCodeSearch
  def initialize(params)
    @params = params
  end

  def error_message
    'There was a problem locating that ZIP Code. Mind trying your search again?'
  end

  def result
    zip_code_tabulation_area = ZipCodeTabulationArea.find_by(zip_code: search_params[:postal_code])

    {
      latitude: zip_code_tabulation_area.latitude,
      longitude: zip_code_tabulation_area.longitude,
      zip_code: zip_code_tabulation_area.zip_code
    }
  end

  def valid?
    search_params.permitted? && /^\d{5}$/.match?(search_params[:postal_code])
  end

  private

  def search_params
    @search_params ||= @params.permit(:postal_code)
  end
end
