class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie

  validates :review_body, presence: true, length: { minimum: 1, message: "needs to be 100 characters or more!  C'mon, tell us what you really think!" }
  validates :movie_id, presence: true, uniqueness: { scope: :user_id, message: "has already been reviewed by you!" }
  validates :rating, presence: true, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 0 }
end
