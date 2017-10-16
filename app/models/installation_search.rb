class InstallationSearch
  def initialize(params)
    @params = params
  end

  def error_message
    'There was a problem locating that installation. Mind trying your search again?'
  end

  def query
    search_params[:query]
  end

  def result
    {
      latitude: installation.latitude,
      longitude: installation.longitude
    }
  end

  def valid?
    search_params.permitted? && installation
  end

  private

  def installation
    @installation ||= Installation.find_by('name ILIKE ?', "%#{search_params[:query]}%")
  end

  def search_params
    @search_params ||= @params.permit(:query)
  end
end
