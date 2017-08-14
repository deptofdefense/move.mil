class EntitlementsController < ApplicationController
  def index
    entitlements
  end

  def show
    entitlement
  end

  private

  def entitlement
    @entitlement ||= Entitlement.find(params[:id])
  end

  def entitlements
    @entitlements ||= Entitlement.all
  end
end
