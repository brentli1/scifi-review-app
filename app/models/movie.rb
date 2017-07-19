class Movie < ActiveRecord::Base
  attr_accessor :date

  validates :title, presence: true
  validates_uniqueness_of :title
  validates :release_date, presence: true
  validates :synopsis, presence: true

  has_many :reviews
end
