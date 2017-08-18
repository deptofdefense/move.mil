RSpec.describe EntitlementsController, type: :request do
  describe 'GET #index' do
    context 'when navigating to the page' do
      before do
        get '/entitlements'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        assert_template 'index'
      end

      it 'highlights the Entitlements navigation item' do
        assert_select '.usa-sidenav-list .usa-current', text: 'Entitlements'
      end
    end

    context 'when performing a search' do
      context 'when sending invalid or incomplete params' do
        before do
          get '/entitlements', params: { foo: 'bar' }, xhr: true
        end

        it 'returns HTTP redirect status code' do
          expect(response).to have_http_status(:not_found)
        end
      end

      context 'when sending valid params' do
        context 'and no results found' do
          before do
            get '/entitlements', params: { dependency_status: true, move_type: 'conus', rank: 'foo' }, xhr: true
          end

          it 'returns HTTP not found status code' do
            expect(response).to have_http_status(:not_found)
          end
        end

        context 'and results found' do
          let!(:entitlement) { create(:entitlement) }

          before do
            get '/entitlements', params: { dependency_status: true, move_type: 'conus', rank: entitlement.rank }, xhr: true
          end

          it 'renders the entitlements table partial' do
            assert_template partial: '_entitlements_table'
          end

          it 'displays a summary of the requested search params' do
            assert_select '.usa-unstyled-list' do
              assert_select 'li:first-child b', text: entitlement.rank
              assert_select 'li:nth-child(2) b', text: 'Yes, I have dependents (spouse/children) that are authorized to move'
              assert_select 'li:last-child b', text: 'CONUS'
            end
          end
        end
      end
    end
  end
end
