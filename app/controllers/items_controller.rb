class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search_item]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    session["devise.regist_data"].clear if session["devise.regist_data"].present?
    @items = Item.all.order(id: 'DESC')
    @p = Item.includes(:item_tags).ransack(params[:q])
  end

  def new
    @item = Item.new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.save_item
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @messages = Message.includes(:user).where(item_id: params[:id]).order(id: 'DESC')
    @message = Message.new
    @p = Item.includes(:item_tags).ransack(params[:q])
  end

  def edit
    redirect_to root_path if !@item.purchase.nil? || !(current_user.id == @item.user.id)
    @item_form = ItemForm.find_item(params[:id])
  end

  def update
    @item_form = ItemForm.new(item_form_params)
    if @item_form.update_item(params[:id])
      redirect_to item_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if current_user.id == @item.user.id
    redirect_to root_path
  end

  def search_tag
    return nil unless params[:keyword].present?
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def search_item
    if params[:q].present?
      params[:q][:price_in] = params[:q][:price_in].split(nil) if params[:q][:price_in].present?
      params[:q][:name_and_description_cont_any] = params[:q][:name_and_description_cont_any].split(/\p{blank}/) if params[:q][:name_and_description_cont_any].present?
    end
    @p = Item.includes(:item_tags).ransack(params[:q])
    @results = @p.result.distinct
  end

  private

  def item_form_params
    params.require(:item_form).permit(
      :name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, :price, :tag, images:[]
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
    
end
