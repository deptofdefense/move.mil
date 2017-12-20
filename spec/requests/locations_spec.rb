RSpec.describe LocationsController, type: :request do
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

    context 'when navigating to the page with coordinates' do
      let!(:transportation_offices) { create_list(:transportation_office, 20) }
      let!(:weight_scales) { create_list(:weight_scale, 20) }

      before do
        get '/resources/locator-maps/38.933366,-77.0303119999999'
      end

      it 'displays a map' do
        assert_select '#locator-map'
      end

      it 'displays a paginated list of transportation offices' do
        assert_select '.transportation-office, .weight-scale', count: 10
        assert_select '.pagination'
      end
    end
  end

  describe 'POST #index' do
    context 'when performing a coordinates search' do
      context 'when sending invalid params' do
        it 'displays an error message' do
          post '/resources/locator-maps', params: { latitude: '-100', longitude: '181' }

          assert_select '.usa-alert-error .usa-alert-text', text: 'There was a problem performing that search. Mind trying again?'
        end
      end

      context 'when sending valid params' do
        it 'redirects to a search results page' do
          post '/resources/locator-maps', params: { latitude: '38.933366', longitude: '-77.0303119999999' }

          expect(response).to redirect_to('/resources/locator-maps/38.933366,-77.0303119999999')
        end
      end
    end

    context 'when performing an installation search' do
      context 'when no search results found' do
        it 'displays an error message' do
          post '/resources/locator-maps', params: { query: 'foo' }

          assert_select '.usa-alert-error .usa-alert-text', text: 'There was a problem locating that installation. Mind trying your search again?'
        end
      end

      context 'when search results found' do
        let!(:installation) { create(:installation) }

        it 'redirects to a search results page' do
          post '/resources/locator-maps', params: { query: 'installation' }

          expect(response).to redirect_to('/resources/locator-maps/38.8718568,-77.0584556')
        end
      end
    end

    context 'when performing a ZIP code search' do
      context 'when no search results found' do
        it 'displays an error message' do
          post '/resources/locator-maps', params: { query: '00000' }

          assert_select '.usa-alert-error .usa-alert-text', text: 'There was a problem locating that ZIP Code. Mind trying your search again?'
        end
      end

      context 'when search results found' do
        let!(:zip_code_tabulation_area) { create(:zip_code_tabulation_area) }

        it 'redirects to a search results page' do
          post '/resources/locator-maps', params: { query: '20010' }

          expect(response).to redirect_to('/resources/locator-maps/38.933366,-77.0303119999999')
        end
      end
    end
  end
end
