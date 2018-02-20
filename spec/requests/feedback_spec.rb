RSpec.describe FeedbackController, type: :request do
  describe 'GET #index' do
    context 'when navigating to the page' do
      before do
        get '/feedback'
      end

      it 'returns HTTP success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        assert_template 'index'
      end
    end
  end

  describe 'POST #index' do
    context 'when submitting invalid params' do
      before do
        post '/feedback', params: { feedback: { topic: '', message: '' } }
      end

      it 'renders the index template' do
        assert_template 'index'
      end

      it 'displays an error message' do
        assert_select '.usa-alert-error .usa-alert-text', text: 'There was a problem submitting your feedback. Mind trying again?'
      end
    end

    context 'when submitting valid params' do
      let(:message_delivery) { instance_double(ActionMailer::MessageDelivery) }

      let :params do
        {
          feedback: {
            message: 'Test feedback message.',
            topic: 'Suggest a New Idea, Feature or Page'
          }
        }
      end

      before do
        allow(message_delivery).to receive(:deliver_now)
      end

      it 'delivers an email' do
        expect(FeedbackMailer).to receive(:feedback_email).with(params[:feedback]).and_return(message_delivery)

        post '/feedback', params: params
      end

      it 'redirects to the thanks page' do
        post '/feedback', params: params

        expect(response).to redirect_to('/feedback/thanks')
      end
    end
  end
end
