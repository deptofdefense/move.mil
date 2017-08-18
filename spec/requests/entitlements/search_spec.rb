RSpec.describe EntitlementsController, type: :request do
  describe 'POST #search' do
    let!(:entitlement) { create(:entitlement) }

    context 'when making a non-XHR request' do
      before do
        post '/entitlements/search', params: { foo: 'bar' }
      end

      it 'returns HTTP redirect status code' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to the index action' do
        expect(response).to redirect_to('/entitlements')
      end
    end

    context 'when sending invalid or incomplete params' do
      before do
        post '/entitlements/search', params: { entitlement: { foo: 'bar' } }, xhr: true
      end

      it 'returns HTTP redirect status code' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to the index action' do
        expect(response).to redirect_to('/entitlements')
      end
    end

    context 'when sending valid params' do
      context 'and no results found' do
        before do
          post '/entitlements/search', params: { entitlement: { dependency_status: true, move_type: 'conus', rank: 'foo' } }, xhr: true
        end

        it 'returns HTTP not found status code' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'and results found' do
        before do
          post '/entitlements/search', params: { entitlement: { dependency_status: true, move_type: 'conus', rank: entitlement.rank } }, xhr: true
        end

        it 'renders the entitlements table partial' do
          assert_template partial: '_entitlements_table'
        end

        it 'displays a summary of the requested search params' do
          assert_select '.usa-unstyled-list' do
            assert_select 'li:first-child b', text: 'E-1'
            assert_select 'li:nth-child(2) b', text: 'Yes, I have dependents (spouse/children) that are authorized to move'
            assert_select 'li:last-child b', text: 'CONUS'
          end
        end
      end
    end
  end
end
