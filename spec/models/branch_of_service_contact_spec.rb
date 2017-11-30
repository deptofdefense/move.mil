RSpec.describe BranchOfServiceContact, type: :model do
  it 'is valid with a branch' do
    expect(BranchOfServiceContact.new(branch_of_service: BranchOfService.create(name: 'Army', display_order: 1))).to be_valid
  end

  it 'is not valid without a branch' do
    expect(BranchOfServiceContact.new(branch_of_service: nil)).to_not be_valid
  end

  it 'returns the first defined phone number in retiree_contact_phone' do
    tel_dsn = '555-1234'
    expect(BranchOfServiceContact.new(retiree_dsn: tel_dsn, retiree_tel_comm: '555-555-9876').retiree_contact_phone?).to eq(tel_dsn)
  end

  it 'returns nil in retiree_contact_phone when no phone numbers are present' do
    expect(BranchOfServiceContact.new.retiree_contact_phone?).to be_nil
  end

  it 'returns the first defined fax number in retiree_contact_fax' do
    fax_dsn = '555-1234'
    expect(BranchOfServiceContact.new(retiree_fax_dsn: fax_dsn, retiree_fax_comm: '555-555-9876').retiree_contact_fax?).to eq(fax_dsn)
  end

  it 'returns nil in retiree_contact_fax when no fax numbers are present' do
    expect(BranchOfServiceContact.new.retiree_contact_fax?).to be_nil
  end
end
