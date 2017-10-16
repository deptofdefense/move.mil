class PpmEstimatorController < ApplicationController

  def index
    entitlements
  end

  private

  def entitlements
    @entitlements ||= Entitlement.all
  end

end
