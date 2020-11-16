class FavoritesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if Favorite.find_by(item_id: params[:item_id], user_id: current_user.id).present?
      Favorite.find_by(item_id: params[:item_id], user_id: current_user.id).destroy
    else
      Favorite.create(item_id: params[:item_id], user_id: current_user.id)
    end

    item = Item.find(params[:item_id])
    if item.favorites.present?
      count = item.favorites.length
    else
      count = 0
    end
    render json: { count: count }
  end
end
