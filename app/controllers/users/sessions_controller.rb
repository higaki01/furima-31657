# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  prepend_before_action :check_captcha, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private
  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_in_params
      respond_with_navigational(resource) { render :new }
    end 
  end
  #   @user = User.new(params.require(:user).permit(:email, :password))
  #   if verify_recaptcha(model: @user) && @user.save
  #     redirect_to @user
  #   else
  #     render 'new'
  #   end
  # end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
