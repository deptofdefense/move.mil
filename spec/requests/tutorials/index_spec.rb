RSpec.describe TutorialsController, type: :request do
  describe 'GET #index' do
    context 'when navigating to the page' do
      before do
        get '/tutorials'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        assert_template 'index'
      end

      it 'highlights the Tutorials navigation item' do
        assert_select '.usa-sidenav-list .usa-current', text: 'Tutorials'
      end
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
