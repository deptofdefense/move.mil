RSpec.describe MetaController, type: :request do
  describe 'GET #browserconfig' do
    context 'when navigating to the page' do
      before do
        get '/browserconfig.xml'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the browserconfig template' do
        assert_template 'browserconfig'
      end
    end
  end

  describe 'GET #manifest' do
    context 'when navigating to the page' do
      before do
        get '/manifest.json'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the manifest template' do
        assert_template 'manifest'
      end
    end
  end

  describe 'GET #sitemap' do
    context 'when navigating to the page' do
      before do
        get '/sitemap.xml'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the sitemap template' do
        assert_template 'sitemap'
      end
    end
  end
end
