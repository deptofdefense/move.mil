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
    let(:latitude) { '38.933366' }
    let(:longitude) { '-77.0303119999999' }

    let(:geoloc) { double(Geokit::GeoLoc) }

    context 'when performing a coordinates search' do
      context 'when sending invalid params' do
        it 'displays an error message' do
          post '/resources/locator-maps', params: { latitude: '-100', longitude: '181' }

          assert_select '.usa-alert-error .usa-alert-text', text: 'There was a problem performing that search. Mind trying again?'
        end
      end

      context 'when sending valid params' do
        it 'redirects to a search results page' do
          post '/resources/locator-maps', params: { latitude: latitude, longitude: longitude }

          expect(response).to redirect_to('/resources/locator-maps/38.933366,-77.0303119999999')
        end
      end
    end

    context 'when performing a text search' do
      context 'when sending invalid params' do
        before do
          allow(Geokit::Geocoders::GoogleGeocoder).to receive(:geocode).and_return(geoloc)
          allow(geoloc).to receive(:success).and_return(false)
        end

        it 'displays an error message' do
          post '/resources/locator-maps', params: { query: '%' }

          assert_select '.usa-alert-error .usa-alert-text', text: 'There was a problem performing that search. Mind trying again?'
        end
      end

      context 'when sending valid params' do
        before do
          allow(Geokit::Geocoders::GoogleGeocoder).to receive(:geocode).and_return(geoloc)
          allow(geoloc).to receive(:success).and_return(true)
          allow(geoloc).to receive(:latitude).and_return(latitude)
          allow(geoloc).to receive(:longitude).and_return(longitude)
        end

        it 'redirects to a search results page' do
          post '/resources/locator-maps', params: { query: '20010' }

          expect(response).to redirect_to('/resources/locator-maps/38.933366,-77.0303119999999')
        end
      end
    end
  end
end
