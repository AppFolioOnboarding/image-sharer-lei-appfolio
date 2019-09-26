class Feedback < ApplicationRecord
  validates :name, presence: true
  validates :comment, presence: true
end
