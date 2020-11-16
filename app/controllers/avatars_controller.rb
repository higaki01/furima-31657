class AvatarsController < ApplicationController
  def create
    binding.pry
    @avatar = Avatar.new(avatar_params)
    @avatar.user_id = current_user.id
    if @avatar.save
      redirect_to mypage_path(current_user.id)
    else
      render '/mypage/params[:id]'
    end
  end

  def update
    @avatar = Avatar.find_by(user_id: current_user.id)
    if @avatar.update(avatar_params)
      redirect_to mypage_path(current_user.id) and return
    else
      render '/mypage/params[:id]' and return
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.avatar.destroy
      redirect_to mypage_path(params[:id])
    else
      render :show
    end
  end

  private

  def avatar_params
    params.require(:user).permit(:image)
  end

end
