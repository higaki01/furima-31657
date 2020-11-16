class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:nickname, :familyname, :firstname, :familyname_kana, :firstname_kana, :birth_date]
    )
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(
      :account_update, keys: [:nickname]
    )
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end

