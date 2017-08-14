RSpec.describe EntitlementsController, type: :request do
  describe 'GET #show' do
    let!(:entitlement) { create(:entitlement) }

    before do
      get "/entitlements/#{entitlement.slug}"
    end

    it 'returns HTTP success status code' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      assert_template 'show'
    end

    it 'highlights the Entitlements navigation item' do
      assert_select '.usa-sidenav-list .usa-current', text: 'Entitlements'
    end

    it 'displays the entitlement' do
      assert_select '.entitlements-table tr:first-child td + td', text: '5,000 lbs.'
    end
  end
end
