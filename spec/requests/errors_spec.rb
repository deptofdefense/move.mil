RSpec.describe ErrorsController, type: :request, realistic_error_responses: true do
  describe 'GET #not_found' do
    before do
      get '/page_that_doesnt_exist.pdf'
    end

    it 'returns HTTP 404 status code' do
      expect(response).to have_http_status(:not_found)
    end

    it 'renders the not found template' do
      assert_template 'not_found'
      assert_select '.not-found-message h1', text: 'Oops...'
    end
  end

  describe 'GET #internal_server_error' do
    before do
      expect(Entitlement).to receive(:all).and_raise('kaboom!')
      get '/entitlements'
    end

    it 'returns HTTP 500 status code' do
      expect(response).to have_http_status(:internal_server_error)
    end

    it 'renders the default rails error page' do
      assert_select '.rails-default-error-page h1', text: 'We\'re sorry, but something went wrong.'
    end
  end
end
