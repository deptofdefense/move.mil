class TransportationOffice < Office
  belongs_to :shipping_office, class_name: 'Office', optional: true

  def self.by_distance_with_shipping_office(latitude:, longitude:)
    includes(:shipping_office).by_distance(origin: [latitude, longitude])
  end
end
