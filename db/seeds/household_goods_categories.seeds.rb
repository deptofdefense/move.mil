require 'json'

module Seeds
  class HouseholdGoodsCategories
    def seed!
      household_goods_categories.each do |household_goods_category|
        HouseholdGoodCategory.create!(household_goods_category.except('household_goods').merge(household_goods_attributes: household_goods_category['household_goods']))
      end
    end

    private

    def household_goods_categories
      JSON.parse(File.read(Rails.root.join('lib', 'data', 'household_goods_weights.json')))
    end
  end
end
