class PpmEstimatorController < ApplicationController
  def index
    return entitlements unless request.xhr?
    return render plain: '', status: :not_found unless ppm_estimator.valid?

    render partial: 'ppm_estimator/estimate_table', locals: { inputs: params }
  end

  private

  def entitlements
    @entitlements ||= Entitlement.all
  end

  def ppm_estimator
    @ppm_estimator ||= PpmEstimator.new(params)
  end
end
