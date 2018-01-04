RSpec.describe Location, type: :model do
  let(:transportation_office) { TransportationOffice.new(name: 'Office') }

  it 'is valid with valid coordinates' do
    expect(Location.new(latitude: 90, longitude: 180, locatable: transportation_office)).to be_valid
    expect(Location.new(latitude: -90, longitude: -180, locatable: transportation_office)).to be_valid
    expect(Location.new(latitude: 0, longitude: 0, locatable: transportation_office)).to be_valid
  end

  it 'is not valid with an invalid latitude' do
    expect(Location.new(latitude: 91, longitude: 180, locatable: transportation_office)).to_not be_valid
    expect(Location.new(latitude: -91, longitude: 180, locatable: transportation_office)).to_not be_valid
  end

  it 'is not valid with an invalid longitude' do
    expect(Location.new(latitude: 90, longitude: 181, locatable: transportation_office)).to_not be_valid
    expect(Location.new(latitude: 90, longitude: -181, locatable: transportation_office)).to_not be_valid
  end
end
