RSpec.describe ServiceSpecificInformationController, type: :request do
  describe 'GET #index' do
    it 'returns HTTP success status code' do
      get '/service-specific-information'

      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/service-specific-information'

      assert_template 'index'
    end

    context 'when service specific posts exist' do
      let!(:service_specific_posts) { create_list(:service_specific_post, 2) }

      it 'displays a list of service specific posts' do
        get '/service-specific-information'

        assert_select '#army' do
          assert_select 'article:nth-child(1)' do
            # The <header> tag starts with the title, but also includes the formatted date after that
            assert_select 'header', text: /\A#{Regexp.quote(service_specific_posts.first.title)}/
            assert_select 'section', text: service_specific_posts.first.content
          end

          assert_select 'article:nth-child(2) header', text: /\A#{Regexp.quote(service_specific_posts.last.title)}/
        end
      end
    end
  end
end
