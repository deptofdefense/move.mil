class WeightEstimatorController < ApplicationController
  def index
    @household_goods_by_category = HouseholdGood.all.group_by(&:category)
  end
end
