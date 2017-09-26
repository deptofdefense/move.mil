class TransportationOffice < Office
  belongs_to :shipping_office, class_name: 'Office', optional: true
end
