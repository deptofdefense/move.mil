RSpec.describe ErrorsController, type: :request do
  describe 'GET #not_found' do
    before do
      get '/404'
    end

    it 'returns HTTP success status code' do
      expect(response).to have_http_status(:not_found)
    end

    it 'renders the not found template' do
      assert_template 'not_found'
      assert_select '.not-found-message h1', text: 'Oops...'
    end
  end
end
