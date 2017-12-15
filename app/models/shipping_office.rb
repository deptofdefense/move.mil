class ShippingOffice < Office
  has_many :transportation_offices, dependent: :destroy
end
