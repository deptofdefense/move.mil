RSpec.describe TutorialsController, type: :request do
  describe 'GET #show' do
    let! :tutorial do
      create(
        :tutorial,
        title: 'Test Tutorial Title'
      )
    end

    before do
      get "/tutorials/#{tutorial.slug}"
    end

    it 'returns HTTP success status code' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      assert_template 'show'
    end

    it 'displays the tutorial' do
      assert_select '.usa-layout-docs-main_content h1', text: 'Test Tutorial Title'

      assert_select '.single-page-tutorial' do
        assert_select 'figure', length: 2
      end
    end
  end
end
