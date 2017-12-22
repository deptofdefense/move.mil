RSpec.describe ErrorsController, type: :request do
  def rails_respond_without_detailed_exceptions
    env_config = Rails.application.env_config
    original_show_exceptions = env_config['action_dispatch.show_exceptions']
    original_show_detailed_exceptions = env_config['action_dispatch.show_detailed_exceptions']
    env_config['action_dispatch.show_exceptions'] = true
    env_config['action_dispatch.show_detailed_exceptions'] = false
    yield
  ensure
    env_config['action_dispatch.show_exceptions'] = original_show_exceptions
    env_config['action_dispatch.show_detailed_exceptions'] = original_show_detailed_exceptions
  end

  describe 'GET #not_found' do
    before do
      rails_respond_without_detailed_exceptions do
        get '/page_that_doesnt_exist.pdf'
      end
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
      rails_respond_without_detailed_exceptions do
        get '/entitlements'
      end
    end

    it 'returns HTTP 500 status code' do
      expect(response).to have_http_status(:internal_server_error)
    end

    it 'renders the default rails error page' do
      assert_select '.rails-default-error-page h1', text: 'We\'re sorry, but something went wrong.'
    end
  end
end
