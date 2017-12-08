RSpec.describe HouseholdGood, type: :model do
  it 'is valid item' do
    expect(HouseholdGood.new(name: 'Chair', weight: 10, household_good_category: HouseholdGoodCategory.create(name: 'Bedroom', icon: 'icons/bedroom.png'))).to be_valid
  end

  it 'is invalid with missing name' do
    expect(HouseholdGood.new(weight: 10, household_good_category: HouseholdGoodCategory.create(name: 'Bedroom', icon: 'icons/bedroom.png'))).to_not be_valid
  end

  it 'is invalid with missing weight' do
    expect(HouseholdGood.new(name: 'Chair', household_good_category: HouseholdGoodCategory.create(name: 'Bedroom', icon: 'icons/bedroom.png'))).to_not be_valid
  end

  it 'is invalid with missing category' do
    expect(HouseholdGood.new(name: 'Chair', weight: 10)).to_not be_valid
  end

  it 'is valid and not duplicate item' do
    bedroom = HouseholdGoodCategory.create(name: 'Bedroom', icon: 'icons/bedroom.png')
    living_room = HouseholdGoodCategory.create(name: 'Living Room', icon: 'icons/living-room.svg')
    HouseholdGood.create(name: 'Chair', weight: 10, household_good_category: bedroom)
    expect(HouseholdGood.new(name: 'Chair', weight: 12, household_good_category: living_room)).to be_valid
  end

  it 'is invalid with duplicate item' do
    bedroom = HouseholdGoodCategory.create(name: 'Bedroom', icon: 'icons/bedroom.png')
    HouseholdGood.create(name: 'Chair', weight: 10, household_good_category: bedroom)
    expect(HouseholdGood.new(name: 'Chair', weight: 12, household_good_category: bedroom)).to_not be_valid
  end

  it 'is expected key' do
    expect(HouseholdGood.new(name: ' Table (Coffee/End) ', weight: 10, household_good_category: HouseholdGoodCategory.create(name: 'Living Room', icon: 'icons/living-room.svg')).key).to eq('table-coffee-end')
  end

  it 'is expected weight key' do
    expect(HouseholdGood.new(name: ' Sofa (2 Cushion) ', weight: 10, household_good_category: HouseholdGoodCategory.create(name: 'Living Room', icon: 'icons/living-room.svg')).weight_key).to eq('sofa-2-cushion_weight')
  end
end
