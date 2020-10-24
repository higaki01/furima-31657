class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_one_attached        :image
  belongs_to_active_hash  :category
  belongs_to_active_hash  :condition
  belongs_to_active_hash  :shipping_cost
  belongs_to_active_hash  :prefecture
  belongs_to_active_hash  :shipping_day
  belongs_to              :user

  validates :image, :name, :description, :price, :user_id, presence: true
  validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1 }
  validates :price, numericality: { onlyh_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 } 
end
