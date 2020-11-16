class Avatar < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :user, :image, presence: true
end
