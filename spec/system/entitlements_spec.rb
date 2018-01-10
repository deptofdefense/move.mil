RSpec.describe EntitlementsController, type: :system do
  describe 'GET #index' do
    let!(:entitlement) { create(:entitlement) }

    before(:each) do
      visit '/entitlements'
    end

    it 'displays a list of ranks' do
      expect(page).to have_selector('#entitlements-rank-list')
      expect(page).not_to have_selector('#entitlements-search')
    end

    it 'displays an entitlements search form', js: true do
      expect(page).to have_selector('#entitlements-search')
      expect(page).not_to have_selector('#entitlements-rank-list')
    end

    it 'displays entitlements based on user input', js: true do
      select 'E-1', from: :rank
      select 'Yes, I have dependents', from: :dependency_status
      select 'Within the Continental United States (CONUS)', from: :move_type

      click_button 'View Results'

      expect(page).to have_selector('#entitlements-search-results') do |content|
        expect(content).to have_text('Military Pay Grade: E-1')
        expect(content).to have_text('Dependency Status: Yes, I have dependents (spouse/children) that are authorized to move')
        expect(content).to have_text('Move Type: CONUS')

        expect(content).to have_selector('.entitlements-table tbody tr:first-child td + td', text: '8,000 lbs.')
      end
    end
  end
end
