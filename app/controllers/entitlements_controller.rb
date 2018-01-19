class EntitlementsController < ApplicationController
  def index
    return entitlements unless request.xhr?
    return render plain: '', status: :not_found unless entitlement_search.valid? && entitlement_search.result

    render partial: 'entitlements/entitlements_table', locals: { entitlement: entitlement_search.result }
  end

  def show
    @entitlement = Entitlement.find(params[:id])
  end

  private

  def entitlement_search
    @entitlement_search ||= EntitlementSearch.new(params)
  end

  def entitlements
    @entitlements ||= Entitlement.all
  end

  # Returns whether the dependency_status XHR parameter matches "status". It's
  # "safe" because it also returns true if no XHR has been made. (It returns
  # true instead of false so that the _entitlements_table always shows content.)
  def safe_dependency_status_check(status)
    @entitlement_search.nil? || @entitlement_search.dependency_status == status
  end
  helper_method :safe_dependency_status_check

  # Returns whether the move_type XHR parameter matches "move_type". It's
  # "safe" because it also returns true if no XHR has been made. (It returns
  # true instead of false so that the _entitlements_table always shows content.)
  def safe_move_type_check(move_type)
    @entitlement_search.nil? || @entitlement_search.move_type == move_type
  end
  helper_method :safe_move_type_check
end
