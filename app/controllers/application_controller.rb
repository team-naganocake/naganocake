class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if Admin
      admin_customers_path
      #とりあえず、会員一覧へ。本当は注文一覧（管理者TOP）画面へ
    else
      root_path #エンドユーザー側のTOP画面へ
    end
  end


  def after_sign_out_path_for(resource)
    if Admin
      new_admin_session_path#管理者ログイン画面へ
    else
      root_path　#エンドユーザー側のTOP画面へ
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :encrypted_password,:is_deleted])
  end

end
