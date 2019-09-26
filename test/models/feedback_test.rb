require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  def test_feedback__ok
    feedback = Feedback.new(name: 'Adam', comment: 'This is good!')
    assert_predicate feedback, :valid?
    assert_equal 'Adam', feedback.name
    assert_equal 'This is good!', feedback.comment
  end

  def test_feedback__empty_name
    feedback = Feedback.new(name: nil, comment: '')
    refute_predicate feedback, :valid?

    feedback = Feedback.new(name: nil, comment: 'Good')
    refute_predicate feedback, :valid?

    feedback = Feedback.new(name: '', comment: '')
    refute_predicate feedback, :valid?

    feedback = Feedback.new(name: '', comment: 'Good!')
    refute_predicate feedback, :valid?
  end

  def test_feedback__empty_comment
    feedback = Feedback.new(name: '', comment: nil)
    refute_predicate feedback, :valid?

    feedback = Feedback.new(name: 'Adam', comment: nil)
    refute_predicate feedback, :valid?

    feedback = Feedback.new(name: '', comment: '')
    refute_predicate feedback, :valid?

    feedback = Feedback.new(name: 'Adam', comment: '')
    refute_predicate feedback, :valid?
  end
end
