RSpec.describe HouseholdGoodCategory, type: :model do
  it 'is valid category' do
    expect(HouseholdGoodCategory.new(name: 'Bedroom', icon: 'icons/bedroom.png')).to be_valid
  end

  it 'is invalid with missing name' do
    expect(HouseholdGoodCategory.new(icon: 'icons/bedroom.png')).to_not be_valid
  end

  it 'is invalid with missing icon' do
    expect(HouseholdGoodCategory.new(name: 'Bedroom')).to_not be_valid
  end

  it 'is is invalid with duplicate name' do
    HouseholdGoodCategory.create(name: 'Bedroom', icon: 'icons/br.png')
    expect(HouseholdGoodCategory.new(name: 'Bedroom', icon: 'icons/bedroom.png')).to_not be_valid
  end
end
