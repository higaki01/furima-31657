class MypagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search_item
  before_action :set_user,        only: [:show, :sale, :sold, :buy, :address, :info]

  def show
    @items = @user.items
    @avatar = Avatar.where(user_id: params[:id]).first_or_initialize
    messages = Message.where(item_id: @items.ids)
    @received_messages = messages.where.not(user_id: params[:id])
    @favorites = @user.favorites
  end

  def sale
    @items = @user.items.includes(:purchase).where(purchases: { id: nil })
  end

  def sold
    @items = @user.items.includes(:purchase).where.not(purchases: { id: nil })
  end

  def buy
    @purchases = @user.purchases.where(user_id: params[:id])
  end

  def address
    if @user.address.present?
      @address = Address.find_by(user_id: params[:id])
    else
      @address = Address.new
    end
  end

  def create_address
    @address = Address.new(address_params)
    if @address.valid?
      @address.save
      redirect_to mypage_path(params[:id]) and return
    else
      render :address and return
    end
  end

  def destroy_address
    address = Address.find_by(user_id: params[:id])
    if address.purchases.present?
      address.update(user_id: nil)
    else
      address.delete
    end
    redirect_to mypage_path(params[:id]) and return
  end

  def card
    if current_user.card.present?
      @card = Card.set_card(params[:id])
    else
      @card = Card.new
    end
  end

  def create_card
    @card = Card.create_card(params[:card_token], params[:id])
    if @card.valid?
      @card.save
      redirect_to mypage_path(params[:id]) and return
    else
      render :card and return
    end
  end

  def destroy_card
    delete_card
    redirect_to card_mypage_path(params[:id])
  end

  def info
  end



  private

  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone).merge(user_id: params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_search_item
    @p = Item.includes(:item_tags).ransack(params[:q])
  end 

  def delete_card
    card = Card.find_by(user_id: params[:id]) 
    customer = Payjp::Customer.retrieve(card.customer_token)
    customer.delete
    card.delete
  end

end 
