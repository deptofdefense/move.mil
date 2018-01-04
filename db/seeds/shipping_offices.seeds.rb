require 'json'

module Seeds
  class ShippingOffices
    def seed!
      shipping_offices.each do |office|
        ShippingOffice.create!(office.except('location').merge(location_attributes: office['location']))
      end
    end

    private

    def shipping_offices
      JSON.load(Rails.root.join('lib', 'data', 'shipping_offices.json'))
    end
  end
end
