RSpec.describe TransportationOffice, type: :model do
  context 'when destroying a Shipping Office' do
    let!(:shipping_office) { create(:shipping_office) }
    let!(:transportation_office) { create(:transportation_office, shipping_office_id: shipping_office.id) }

    it 'should be destroyed' do
      shipping_office.destroy

      expect(TransportationOffice.all).not_to include(transportation_office)
    end
  end
end
