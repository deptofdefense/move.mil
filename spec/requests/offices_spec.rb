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
    end

    context 'when performing a ZIP code search' do
      context 'when sending invalid or incomplete params' do
        it 'displays an error message' do
          get '/resources/locator-maps', params: { postal_code: 'foo' }

          assert_select '.usa-alert-error .usa-alert-text', text: 'There was a problem locating that ZIP Code. Mind trying your search again?'
        end
      end

      context 'when sending valid params' do
        let!(:zip_code_tabulation_area) { create(:zip_code_tabulation_area) }
        let!(:transportation_offices) { create_list(:transportation_office, 20) }

        before do
          get '/resources/locator-maps', params: { postal_code: '20010' }
        end

        it 'displays a map' do
          assert_select '#locator-map'
        end

        it 'displays a paginated list of transportation offices' do
          assert_select '.transportation-office', count: 10
          assert_select '.pagination'
        end
      end
    end

    context 'when performing a coordinates search' do
      context 'when sending invalid or incomplete params' do
        it 'displays an error message' do
          get '/resources/locator-maps', params: { coordinates: '-100,181' }

          assert_select '.usa-alert-error .usa-alert-text', text: 'There was a problem performing that search. Mind trying again?'
        end
      end

      context 'when sending valid params' do
        let!(:transportation_offices) { create_list(:transportation_office, 20) }

        before do
          get '/resources/locator-maps', params: { coordinates: '38.933366,-77.0303119999999' }
        end

        it 'displays a map' do
          assert_select '#locator-map'
        end

        it 'displays a paginated list of transportation offices' do
          assert_select '.transportation-office', count: 10
          assert_select '.pagination'
        end
      end
    end
  end
end
