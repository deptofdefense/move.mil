RSpec.describe ConusLinehaul, type: :model do
  let!(:linehaul_2401to2500miles_1000to1099lbs) { create(:conus_linehaul, dist_mi: Range.new(2401, 2500), weight_lbs: Range.new(1000, 1099), rate: 3060, effective: Range.new(Date.parse('2017-05-15'), Date.parse('2018-05-14'))) }

  it 'prorates weights under 1000 lbs' do
    expect(ConusLinehaul.rate(Date.parse('2017-12-31'), 2450, 750)).to eq(2295)
  end
end
