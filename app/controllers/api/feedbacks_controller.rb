module Api
  class FeedbacksController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      feedback = Feedback.new(feedback_params)
      if feedback.save
        head :no_content, content_type: 'text/html'
      else
        head :unprocessable_entity, content_type: 'text/html'
      end
    end

    private

    def feedback_params
      params.require(:feedback).permit(:name, :comment)
    end
  end
end
