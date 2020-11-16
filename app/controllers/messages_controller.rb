class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    item = Item.find(params[:message][:item_id])
    user = item.user
    if current_user.avatar.present?
      avatar = url_for(current_user.avatar.image)
    else
      avatar = nil
    end
    
    if message.save
      ActionCable.server.broadcast 'message_channel', message: message, user: user, avatar: avatar
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :user_id, :item_id)
  end

end
