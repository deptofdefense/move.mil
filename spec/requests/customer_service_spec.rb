RSpec.describe CustomerServiceController, type: :request do
  describe 'GET #index' do
    context 'when navigating to the page' do
      before do
        get '/customer-service'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        assert_template 'index'
      end
    end

    context 'when contacts exist' do
      let!(:branches) { create_list(:branch_of_service, 5) }

      it 'displays customer service contacts' do
        get '/customer-service'

        assert_select '#svc-help' do
          # Although there are 3 phone numbers, ensure that there's only one "Phone" header
          assert_select 'tr:first-child th', text: 'Phone'
          assert_select 'tr:nth-child(2) td:first-child', text: ''
          assert_select 'tr:nth-child(3) td:first-child', text: ''

          # Check that the phone numbers have tel: links
          assert_select 'tr:nth-child(2) td:nth-child(2) a[href^="tel"]'
          assert_select 'tr:nth-child(3) td:nth-child(2) a[href^="tel"]'

          # Check that the email address has a mailto: link
          assert_select 'tr:nth-child(4) td:nth-child(2) a[href^="mailto"]'
        end

        assert_select '#claims' do
          # Check that the phone numbers have tel: links
          assert_select 'tr:nth-child(2) td:nth-child(2) a[href^="tel"]'
          assert_select 'tr:nth-child(3) td:nth-child(2) a[href^="tel"]'

          # Check that the email address has a mailto: link
          assert_select 'tr:nth-child(4) td:nth-child(2) a[href^="mailto"]'

          # Check that the fax numbers do NOT have links
          assert_select 'tr:nth-child(5) td:nth-child(2) a', false
          assert_select 'tr:nth-child(6) td:nth-child(2) a', false
          assert_select 'tr:nth-child(7) td:nth-child(2) a', false
        end

        assert_select '#retirement-separation' do
          # Check that the phone numbers have tel: links
          assert_select 'tr:nth-child(2) td:nth-child(2) a[href^="tel"]'
          assert_select 'tr:nth-child(3) td:nth-child(2) a[href^="tel"]'

          # Check that the email address has a mailto: link
          assert_select 'tr:nth-child(4) td:nth-child(2) a[href^="mailto"]'

          # Check that the fax numbers do NOT have links
          assert_select 'tr:nth-child(5) td:nth-child(2) a', false
          assert_select 'tr:nth-child(6) td:nth-child(2) a', false
          assert_select 'tr:nth-child(7) td:nth-child(2) a', false
        end
      end
    end
  end
end
