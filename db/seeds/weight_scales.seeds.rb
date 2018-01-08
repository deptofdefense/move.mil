require 'json'

module Seeds
  class WeightScales
    def seed!
      weight_scales.each do |weight_scale|
        WeightScale.create!(weight_scale.except('location').merge(location_attributes: weight_scale['location']))
      end
    end

    private

    def weight_scales
      JSON.parse(File.read(Rails.root.join('lib', 'data', 'weight_scales.json')))
    end
  end
end
