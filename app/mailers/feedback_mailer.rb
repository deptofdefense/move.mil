class FeedbackMailer < ApplicationMailer
  default from: ENV['FEEDBACK_EMAIL_SENDER']

  def feedback_email(message:, topic:)
    @message = message
    @topic = topic

    mail(to: ENV['FEEDBACK_EMAIL_RECIPIENT'], subject: "Move.mil Feedback: #{@topic}")
  end
end
