RSpec.describe TutorialsController, type: :request do
  describe 'GET /tutorials' do
    let!(:tutorial) { create(:tutorial) }

    before do
      get '/tutorials'
    end

    it 'returns HTTP success status code' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      assert_template 'show'
    end
  end

  describe 'GET /tutorials/:id' do
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
      assert_select '.main-section h3', text: 'Test Tutorial Title'

      assert_select 'figure', length: 2
    end
  end
end
