RSpec.describe WeightEstimatorController, type: :request do
  describe 'GET #index' do
    context 'when navigating to the page' do
      before do
        get '/resources/weight-estimator'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        assert_template 'index'
      end

      it 'highlights the Weight Estimator navigation item' do
        assert_select '.usa-sidenav-list .usa-current', text: 'Weight Estimator'
      end
    end

    context 'when service specific posts exist' do
      let!(:bedroom_household_goods) { create_list(:household_good, 4, category: 'Bedroom') }
      let!(:living_room_household_goods) { create_list(:household_good, 2, category: 'Living Room') }

      it 'displays a list of household good categories' do
        get '/resources/weight-estimator'

        assert_select '#weight-estimator-form' do
          assert_select '.usa-accordion-bordered:nth-child(1)' do
            assert_select '.usa-accordion-button', text: 'Bedroom'
            assert_select '.usa-accordion-content' do
              assert_select '.hhg-quantity-input', count: 4
              assert_select '.hhg-weight', count: 4
            end
          end

          assert_select '.usa-accordion-bordered:nth-child(2)' do
            assert_select '.usa-accordion-button', text: 'Living Room'
            assert_select '.usa-accordion-content' do
              assert_select '.hhg-quantity-input', count: 2
              assert_select '.hhg-weight', count: 2
            end
          end
        end
      end
    end
  end
end
