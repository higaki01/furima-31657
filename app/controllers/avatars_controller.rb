class AvatarsController < ApplicationController
  def create
    @avatar = Avatar.new(avatar_params)
    @avatar.user_id = current_user.id
    redirect_to mypage_path(current_user.id) and return if @avatar.save

    render '/mypage/params[:id]' and return
  end

  def update
    @avatar = Avatar.find_by(user_id: current_user.id)
    redirect_to mypage_path(current_user.id) and return if @avatar.update(avatar_params)

    render '/mypage/params[:id]' and return
  end

  def destroy
    user = User.find(params[:id])
    redirect_to mypage_path(params[:id]) and return if user.avatar.destroy

    render :show and return
  end

  private

  def avatar_params
    params.require(:user).permit(:image)
  end
end
