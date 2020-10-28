class Form
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone, :token

  with_options presence: true do
    validates :city, :address, :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Input correctly' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }
    validates :phone, format: { with: /\A[0-9]+\z/, message: 'Input only number' }
  end

  def save(user_id, item_id)
    Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone: phone
    )
  end
end
