RSpec.describe ServiceSpecificInformationController, type: :request do
  describe 'GET #index' do
    context 'when navigating to the page' do
      before do
        get '/service-specific-information'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        assert_template 'index'
      end
    end
  end
end
