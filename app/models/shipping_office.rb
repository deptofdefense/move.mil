class ShippingOffice < Office
  has_many :transportation_offices, class_name: 'Office', foreign_key: :shipping_office_id, dependent: :destroy
end
