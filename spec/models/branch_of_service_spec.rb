RSpec.describe BranchOfService, type: :model do
  it 'is valid with a name' do
    expect(BranchOfService.new(name: 'Army', display_order: 1)).to be_valid
  end

  it 'is not valid without a name' do
    expect(BranchOfService.new(name: nil, display_order: 1)).to_not be_valid
  end

  it 'is not valid without a display order' do
    expect(BranchOfService.new(name: 'Army')).to_not be_valid
  end
end
