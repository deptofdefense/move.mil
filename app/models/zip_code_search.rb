class ZipCodeSearch
  def initialize(params)
    @params = params
  end

  def result
    ZipCodeTabulationArea.find_by(zip_code: search_params[:postal_code])
  end

  def valid?
    search_params.permitted? && /^\d{5}$/.match?(search_params[:postal_code])
  end

  private

  def search_params
    @search_params ||= @params.permit(:postal_code)
  end
end
