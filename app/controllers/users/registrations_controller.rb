# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :set_search_params, only: [:edit]

  def new_index
  end

  def new
    if session['devise.regist_data'].present?
      @user = User.new(session['devise.regist_data']['user'])
    else
      @user = User.new
    end
  end
 
  def create
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
    @user = User.new(sign_up_params)
    if @user.valid?
      session['devise.regist_data'] = { user: @user.attributes }
      session['devise.regist_data'][:user]['password'] = params[:user][:password]
      redirect_to users_addresses_path
    else
      render :new and return
    end
  end

  def new_address
    if session['devise.regist_data']['address'].present?
      @address = Address.new(session['devise.regist_data']['address'])
    else
      @address = Address.new
    end
  end

  def create_address
    @address = Address.new(address_params)
    if @address.invalid?
      render :new_address and return
    else
      session['devise.regist_data']['address'] = @address.attributes
      redirect_to users_cards_path and return
    end
  end

  def new_card
    @card = Card.new
  end

  def create_card
    user = User.new(session['devise.regist_data']['user'])
    @card = Card.create_card(params[:card_token], nil)
    if @card.valid?
      card = user.build_card(@card.attributes)
    else
      render :new_card and return
    end
    address = user.build_address(session['devise.regist_data']['address']) if session['devise.regist_data']['address'].present?
    user.save
    redirect_to root_path and return
  end

  def create_completion
    user = User.new(session['devise.regist_data']['user'])
    address = user.build_address(session['devise.regist_data']['address']) if session['devise.regist_data']['address'].present?
    user.save
    sign_in_and_redirect user
  end  

  private
 
  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone)
  end

  def set_search_params
    @p = Item.includes(:item_tags).ransack(params[:q])
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
