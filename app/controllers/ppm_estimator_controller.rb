class PpmEstimatorController < ApplicationController
  def index
    return lookups unless request.xhr?
    return render plain: '', status: :not_found unless ppm_estimator.valid?

    render partial: 'ppm_estimator/estimate_table', locals: { inputs: params }
  end

  private

  def branches
    @branches ||= BranchOfService.select(:name, :slug)
  end

  def entitlements
    @entitlements ||= Entitlement.all
  end

  # populate some of the drop downs in the form
  def lookups
    entitlements
    branches
  end

  def ppm_estimator
    @ppm_estimator ||= PpmEstimator.new(params)
  end
end
