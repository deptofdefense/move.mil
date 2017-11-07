class PpmEstimatorController < ApplicationController
  def index
    # The entitlements are used to populate some of the drop downs in the form
    return entitlements unless request.xhr?
    return render plain: '', status: :not_found unless ppm_estimator.valid? && ppm_estimator.result

    render partial: 'ppm_estimator/estimate_table', locals: ppm_estimator.result
  end

  private

  def entitlements
    @entitlements ||= Entitlement.all
    @entitlements_json ||= @entitlements.to_json
  end

  def ppm_estimator
    @ppm_estimator ||= PpmEstimator.new(params)
  end
end
