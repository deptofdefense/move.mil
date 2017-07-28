RSpec.describe TutorialsController, type: :request do
  describe "GET #index" do
    it 'returns HTTP success status code' do
      get '/tutorials'

      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/tutorials'

      assert_template 'index'
    end

    context 'when tutorials exist' do
      let!(:tutorials) { create_list(:tutorial, 2) }

      it 'displays a list of tutorials' do
        get '/tutorials'

        assert_select '.usa-accordion-bordered' do
          assert_select 'li:nth-child(1)' do
            assert_select '.usa-accordion-button', text: tutorials.first.title
            assert_select '.carousel-item', length: 2
          end

          assert_select 'li:nth-child(2) .usa-accordion-button', text: tutorials.last.title
        end
      end
    end
  end
end
