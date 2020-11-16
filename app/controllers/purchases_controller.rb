class PurchasesController < ApplicationController
  before_action :set_item,   only: [:index, :create]
  before_action :check_sold, only: [:index, :create]

  def index
    @form = Form.new
    @card = Card.set_card(current_user.id) if current_user.card.present?
    @address = current_user.address if current_user.card.present?
  end

  def create
    @form = Form.new(form_params)
    @form.enter_card_in_form(current_user.card) if params[:check_card]
    @form.enter_address_in_form(current_user.address) if params[:check_address]

    if @form.valid?
      @form.save_purchase(current_user.id, params[:item_id], params[:check_address])
    else
      render action: :index and return
    end

    if params[:check_card]
      Card.pay_registration_card(@item.price, @form.token)
    else
      Card.pay_new_card(@item.price, @form.token)
    end
    redirect_to root_path and return
  end

  private

  def form_params
    params.require(:form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone).merge(token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_sold
    redirect_to root_path and return if @item.purchase.present? || current_user.id == @item.user_id
    redirect_to new_user_session_path and return unless user_signed_in?
  end
end
