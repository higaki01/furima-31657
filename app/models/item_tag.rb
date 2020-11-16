class ItemTag < ApplicationRecord
  belongs_to :item
  belongs_to :tag

  validates :item_id, :tag_id, presence: true
end
