RSpec.describe Location, type: :model do
  it 'is valid with valid coordinates' do
    expect(Location.new(latitude: 90, longitude: 180, locatable: TransportationOffice.new(name: 'Office'))).to be_valid
    expect(Location.new(latitude: -90, longitude: -180, locatable: TransportationOffice.new(name: 'Office'))).to be_valid
    expect(Location.new(latitude: 0, longitude: 0, locatable: TransportationOffice.new(name: 'Office'))).to be_valid
  end

  it 'is not valid with an invalid latitude' do
    expect(Location.new(latitude: 91, longitude: 180, locatable: TransportationOffice.new(name: 'Office'))).to_not be_valid
    expect(Location.new(latitude: -91, longitude: 180, locatable: TransportationOffice.new(name: 'Office'))).to_not be_valid
  end

  it 'is not valid with an invalid longitude' do
    expect(Location.new(latitude: 90, longitude: 181, locatable: TransportationOffice.new(name: 'Office'))).to_not be_valid
    expect(Location.new(latitude: 90, longitude: -181, locatable: TransportationOffice.new(name: 'Office'))).to_not be_valid
  end
end
