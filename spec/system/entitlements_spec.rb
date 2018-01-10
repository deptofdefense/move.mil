RSpec.describe 'Entitlements', type: :system do
  describe 'GET #index', js: true do
    let!(:entitlement) { create(:entitlement) }

    before do
      visit '/entitlements'

      select 'E-1', from: :rank
      select 'Yes, I have dependents', from: :dependency_status
      select 'Within the Continental United States (CONUS)', from: :move_type

      click_button 'View Results'
    end

    it 'displays entitlements based on user input' do
      expect(page).to have_selector('#entitlements-search-results') do |content|
        expect(content).to have_text('Military Pay Grade: E-1')
        expect(content).to have_text('Dependency Status: Yes, I have dependents (spouse/children) that are authorized to move')
        expect(content).to have_text('Move Type: CONUS')

        expect(content).to have_selector('.entitlements-table tbody tr:first-child td + td', text: '8,000 lbs.')
      end
    end
  end
end
