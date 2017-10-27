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
    end

    context 'household goods exist' do
      let!(:bedroom) { create(:household_good_category, name: 'Bedroom', household_goods_count: 4) }
      let!(:living_room) { create(:household_good_category, name: 'Living Room', household_goods_count: 2) }

      it 'displays a list of household good categories' do
        get '/resources/weight-estimator'

        assert_select '#weight-estimator' do
          assert_select '.hhg-category:nth-child(1)' do
            assert_select '.hhg-category-header span', text: 'Bedroom'
            assert_select '.hhg-category-section-one' do
              assert_select '.hhg-quantity-input', count: 4
              assert_select '.hhg-weight', count: 4
            end
            assert_select '.hhg-category-section-two' do
              assert_select '.hhg-weight-input', count: 3
              assert_select '.category-estimate-input[id=?]', 'bedroom_subtotal'
              assert_select '.category-estimate-input[id=?]', 'bedroom_total'
            end
          end

          assert_select '.hhg-category:nth-child(2)' do
            assert_select '.hhg-category-header span', text: 'Living Room'
            assert_select '.hhg-category-section-one' do
              assert_select '.hhg-quantity-input', count: 2
              assert_select '.hhg-weight', count: 2
            end
            assert_select '.hhg-category-section-two' do
              assert_select '.hhg-weight-input', count: 3
              assert_select '.category-estimate-input[id=?]', 'living-room_subtotal'
              assert_select '.category-estimate-input[id=?]', 'living-room_total'
            end
          end
        end
      end
    end
  end
end
