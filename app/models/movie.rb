class Movie < ActiveRecord::Base
  attr_accessor :date
  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates_uniqueness_of :title
  validates :release_date, presence: true
  validates :synopsis, presence: true
  validates :image, presence: { message: "is required." }
  validate :image_size

  has_many :reviews, dependent: :destroy
  has_many :movie_categories
  has_many :categories, through: :movie_categories

  private
  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end
end
