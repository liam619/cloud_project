class Distributor < ApplicationRecord

  has_and_belongs_to_many :books

  VALID_LOCATION = /\A[\d]{2}+\.[\d]{2}+\.[\d]{2}\z/
  validates :name, presence: true, length:  { minimum:  10 }
end