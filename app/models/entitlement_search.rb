class EntitlementSearch
  def initialize(params)
    @params = params
  end

  def dependency_status
    search_params[:dependency_status]
  end

  def move_type
    search_params[:move_type]
  end

  def rank
    search_params[:rank]
  end

  def result
    Entitlement.find_by(rank: rank)
  end

  def valid?
    search_params.permitted? && dependency_status.present? && move_type.present? && rank.present?
  end

  private

  def search_params
    @search_params ||= @params.permit(:dependency_status, :move_type, :rank)
  end
end
