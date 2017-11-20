class WeightEstimatorController < ApplicationController
  def index
    @household_good_categories = HouseholdGoodCategory.includes(:household_goods).all
  end
end
