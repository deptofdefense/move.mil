require 'json'

module Seeds
  class TransportationOffices
    def seed!
      transportation_offices.each do |office|
        shipping_office = ShippingOffice.where(name: office['shipping_office_name']).first

        TransportationOffice.create!(office.except('location', 'shipping_office_name').merge(location_attributes: office['location'], shipping_office: shipping_office))
      end
    end

    private

    def transportation_offices
      JSON.load(Rails.root.join('lib', 'data', 'transportation_offices.json'))
    end
  end
end
