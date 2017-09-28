RSpec.describe OfficesController, type: :request do
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

    context 'when performing a search' do
      context 'when sending invalid or incomplete params' do
        it 'displays an error message' do
          get '/resources/locator-maps', params: { postal_code: 'foo' }

          assert_select '.usa-alert-error .usa-alert-text', text: 'There was a problem locating that ZIP Code. Mind trying your search again?'
        end
      end

      context 'when sending valid params' do
        let!(:zip_code_tabulation_area) { create(:zip_code_tabulation_area) }
        let!(:transportation_offices) { create_list(:transportation_office, 20) }

        it 'displays a paginated list of transportation offices' do
          get '/resources/locator-maps', params: { postal_code: '20010' }

          assert_select '.transportation-office', count: 10
          assert_select '.pagination'
        end
      end
    end
  end
end
