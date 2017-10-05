RSpec.describe HouseholdGood, type: :model do
  it 'is valid item' do
    expect(HouseholdGood.new(name: 'Chair', weight: 10, category: 'Dining Room')).to be_valid
  end

  it 'is invalid with missing name' do
    expect(HouseholdGood.new(weight: 10, category: 'Dining Room')).to_not be_valid
  end

  it 'is invalid with missing weight' do
    expect(HouseholdGood.new(name: 'Chair', category: 'Dining Room')).to_not be_valid
  end

  it 'is invalid with missing category' do
    expect(HouseholdGood.new(name: 'Chair', weight: 10)).to_not be_valid
  end

  it 'is valid and not duplicate item' do
    HouseholdGood.create(name: 'Chair', weight: 10, category: 'Dining Room')
    expect(HouseholdGood.new(name: 'Chair', weight: 10, category: 'Living Room')).to be_valid
  end

  it 'is invalid with duplicate item' do
    HouseholdGood.create(name: 'Chair', weight: 10, category: 'Dining Room')
    expect(HouseholdGood.new(name: 'Chair', weight: 10, category: 'Dining Room')).to_not be_valid
  end
end
