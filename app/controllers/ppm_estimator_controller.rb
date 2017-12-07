class PpmEstimatorController < ApplicationController
  def index
    return lookups unless request.xhr?
    return render plain: '', status: :not_found unless ppm_estimator.valid?

    render partial: 'ppm_estimator/estimate_table'
  end

  private

  # populate some of the drop downs in the form
  def lookups
    @entitlements ||= Entitlement.all
    @branches ||= BranchOfService.select(:name, :slug)
  end

  def ppm_estimator
    @ppm_estimator ||= PpmEstimator.new(params)
  end
end
