require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  def test_create__succeed
    assert_difference('Feedback.count', 1) do
      feedback_params = { name: 'Alice', comment: 'this is fun.' }
      post api_feedbacks_path, params: { feedback: feedback_params }
    end

    assert_response :no_content
  end

  def test_create__fail_name_nil
    assert_no_difference('Feedback.count') do
      feedback_params = { name: nil, comment: 'this is funny.' }
      post api_feedbacks_path, params: { feedback: feedback_params }
    end

    assert_response :unprocessable_entity
  end

  def test_create__fail_name_empty
    assert_no_difference('Feedback.count') do
      feedback_params = { name: '', comment: 'this is fun.' }
      post api_feedbacks_path, params: { feedback: feedback_params }
    end

    assert_response :unprocessable_entity
  end

  def test_create__fail_comment_nil
    assert_no_difference('Feedback.count') do
      feedback_params = { name: 'Bob', comment: nil }
      post api_feedbacks_path, params: { feedback: feedback_params }
    end

    assert_response :unprocessable_entity
  end

  def test_create__fail_comment_empty
    assert_no_difference('Feedback.count') do
      feedback_params = { name: 'Panda', comment: '' }
      post api_feedbacks_path, params: { feedback: feedback_params }
    end

    assert_response :unprocessable_entity
  end
end
