class Card < ApplicationRecord
  belongs_to :user, optional: true

  validates :card_token, :customer_token, presence: true

  def self.set_card(user_id)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: user_id)
    customer = Payjp::Customer.retrieve(card.customer_token)
    return customer.cards.first
  end

  def self.create_card(card_token, user_id)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] 
    customer = Payjp::Customer.create(
      description: 'test', 
      card: card_token
    )
    return Card.new( 
      card_token: card_token, 
      customer_token: customer.id,
      user_id: user_id
    )
  end

  def self.pay_new_card(price, token)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: price,
      card: token,
      currency: 'jpy'
    )
  end

  def self.pay_registration_card(price, token)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: price,
      customer: token,
      currency: 'jpy' 
      )
  end
end
