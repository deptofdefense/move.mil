RSpec.describe LocatorMapsController, type: :request do
  describe 'GET #index' do
    context 'when navigating to the page' do
      before do
        get '/resources/locator-maps'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        assert_template 'index'
      end

      it 'highlights the Locator Maps navigation item' do
        assert_select '.usa-sidenav-list .usa-current', text: 'Locator Maps'
      end
    end
  end
end
