class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
  end

  def create
    binding.pry
    Item.create(item_params)
    render :index
  end

  private
  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_day_id, :price
    ).merge(user_id: current_user.id)
  end
end
