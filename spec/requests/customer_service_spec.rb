RSpec.describe ServiceSpecificInformationController, type: :request do
  describe 'GET #index' do
    it 'returns HTTP success status code' do
      get '/customer-service'

      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/customer-service'

      assert_template 'index'
    end

    context 'when customer service contacts exist' do
      let!(:branch_of_service_contacts) { create_list(:branch_of_service_contact, 2) }

      it 'displays service specific contacts' do
        get '/customer-service'

        assert_select '#svc-help' do
          # Although there are 3 phone numbers, ensure that there's only one "Phone" header

          # Check that the phone numbers have tel: links

          # Check that the email address has a mailto: link

          # Check that the fax numbers do NOT have links

        end

        assert_select '#claims' do
          # Check that the phone numbers have tel: links

          # Check that the email address has a mailto: link

          # Check that the fax numbers do NOT have links
        end

        assert_select '#retirement-separation'
          # Check that the phone numbers have tel: links

          # Check that the email address has a mailto: link

          # Check that the fax numbers do NOT have links
        end
      end
    end
  end
end
