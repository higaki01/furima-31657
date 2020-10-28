class PurchasesController < ApplicationController
  before_action :set_item, only: [:index, :create]


  def index
    @form = Form.new
    if !@item.purchase.nil?
      redirect_to root_path
    elsif !user_signed_in?
      redirect_to new_user_session_path
    elsif current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def create
    redirect_to root_path unless @item.purchase.nil?
    @form = Form.new(form_params)
    if @form.valid?
      @form.save(current_user.id, params[:item_id])
      pay_item
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def form_params
    params.require(:form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: @form.token,
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
