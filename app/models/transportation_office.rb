class TransportationOffice < Office
  # rubocop:disable Rails/InverseOf
  belongs_to :shipping_office, foreign_key: :shipping_office_id, optional: true
  # rubocop:enable Rails/InverseOf

  def self.by_distance_with_shipping_office(latitude:, longitude:)
    includes(:shipping_office).by_distance(origin: [latitude, longitude])
  end
end
