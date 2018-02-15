RSpec.describe FeedbackMailer, type: :mailer do
  describe '#feedback_email' do
    let :email_opts do
      {
        message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        topic: 'Lorem ipsum dolor sit amet'
      }
    end

    let(:email) { described_class.feedback_email(email_opts).deliver_now }

    it 'renders the subject' do
      expect(email.subject).to eq("Move.mil Feedback: #{email_opts[:topic]}")
    end

    it 'renders the body' do
      expect(email.body.encoded).to include("## Topic\r\n\r\nLorem ipsum dolor sit amet")
      expect(email.body.encoded).to include("## Message\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor \r\n")
    end
  end
end
