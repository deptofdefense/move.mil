RSpec.describe LocationsController, type: :controller do
  describe 'POST #index' do
    context 'when performing a text search' do
      it 'assigns @search' do
        post :index, params: { query: 'Fort Belvoir' }

        expect(assigns(:search).query).to eq('Fort Belvoir')
      end
    end
  end
end
