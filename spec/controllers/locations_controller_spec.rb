RSpec.describe LocationsController, type: :controller do
  describe 'POST #index' do
    context 'when performing an installation search' do
      it 'assigns @search' do
        post :index, params: { query: 'installation' }

        expect(assigns(:search).query).to eq('installation')
      end
    end

    context 'when performing a ZIP code search' do
      context 'with a zero-prefixed query' do
        it 'assigns @search' do
          post :index, params: { query: '601' }

          expect(assigns(:search).query).to eq('00601')
        end
      end

      context 'with a non-zero-prefixed query' do
        it 'assigns @search' do
          post :index, params: { query: '20010' }

          expect(assigns(:search).query).to eq('20010')
        end
      end
    end
  end
end
