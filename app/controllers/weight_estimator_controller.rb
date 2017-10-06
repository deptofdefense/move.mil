class WeightEstimatorController < ApplicationController
  def index
    household_goods_by_category
  end

  def household_goods_by_category
    @household_goods_by_category ||= HouseholdGood.all.group_by(&:category)
  end
end
