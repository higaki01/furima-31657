class Form
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :purchase_id, :phone, :token

  with_options presence: true do
    validates :city, :address, :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンあり7桁で入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :phone, format: { with: /\A[0-9]+\z/, message: 'はハイフンなし11桁以内で入力してください' }
  end

  def save(user_id, item_id)
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, 
      building: building, phone: phone, purchase_id: purchase.id
    )
  end
end
