class Book < ApplicationRecord
  belongs_to :author

  has_and_belongs_to_many :distributors
  has_and_belongs_to_many :categories
  # has_and_belongs_to_many :prerequisites

  # has_many :like_courses, dependent: :destroy
  # has_many :dislike_courses, dependent: :destroy

  validates :name, presence: true, length:  { minimum:  3 }
  validates :description, presence: true, length: { minimum: 30 }
  validates :categories, presence: true
  validates :distributors, presence: true
  # mount_uploader :image, ImageUploader
  # validate :image_size

  # def image_size
  #   if image.size > 5.megabytes
  #     errors.add(:image, "should be less than 5MB")
  #   end
  # end
end
