class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :purchases
  belongs_to :user,     optional: true

  with_options presence: true do
    validates :city, :address
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンあり7桁で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :phone, format: { with: /\A[0-9]+\z/, message: 'はハイフンなし11桁以内で入力してください' }
  end

end
