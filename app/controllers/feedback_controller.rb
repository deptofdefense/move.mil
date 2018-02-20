class FeedbackController < ApplicationController
  def index
    topics
  end

  def create
    if valid_submission?
      FeedbackMailer.feedback_email(
        message: feedback_params[:message],
        topic: feedback_params[:topic]
      ).deliver_now

      redirect_to feedback_thanks_path
    else
      @error_message = 'There was a problem submitting your feedback. Mind trying again?'

      render :index
    end
  end

  private

  def feedback_params
    @feedback_params ||= params.require(:feedback).permit(:honeybucket, :message, :topic)
  end

  def valid_submission?
    feedback_params.permitted? &&
      topics.include?(feedback_params[:topic]) &&
      feedback_params[:message].present? &&
      feedback_params[:honeybucket].blank?
  end

  def topics
    @topics ||= [
      'Suggest a New Idea, Feature or Page',
      'Inaccurate Content or Information',
      'Bad Contact Info',
      'General Suggestions',
      'Request for New/Missing Content',
      'Other'
    ]
  end
end
