class WeightEstimatorController < ApplicationController
  def index
    @household_good_categories = HouseholdGoodCategory.all
  end
end
