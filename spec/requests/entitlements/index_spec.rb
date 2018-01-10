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
      end
    end
  end
end
