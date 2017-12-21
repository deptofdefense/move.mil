RSpec.describe ServiceSpecificInformationController, type: :request do
  describe 'GET #show' do
    let!(:branch) { create(:branch_of_service, name: 'Army') }
    context 'when navigating to the page' do
      before do
        get '/service-specific-information'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the show template' do
        assert_template 'show'
      end
    end

    context 'when service specific posts exist' do
      let!(:branch) { create(:branch_of_service, name: 'Navy') }

      it 'displays a list of service specific posts' do
        get '/service-specific-information/navy'

        assert_select '.post', 2

        # The first child is the "Announcements" header
        assert_select '.post:nth-child(2) strong', text: branch.service_specific_posts.first.title
      end

      it 'displays customer service contact information' do
        get '/service-specific-information/navy'

        assert_select '.svc-spec-links:first-child' do
          assert_select 'header', text: branch.name + ' Customer Service'
          assert_select 'tr:first-child td', text: branch.branch_of_service_contact.custsvc_dsn
        end

        assert_select '.svc-spec-links:nth-child(2)' do
          assert_select 'header', text: 'Claims'
          assert_select 'tr:first-child td', text: branch.branch_of_service_contact.claims_dsn
        end

        assert_select '.svc-spec-links:nth-child(3)' do
          assert_select 'header', text: 'Retirement/Separation HHG Extensions'
          assert_select 'tr:first-child td', text: branch.branch_of_service_contact.retiree_dsn
        end
      end
    end
  end
end
