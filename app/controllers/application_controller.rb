class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

  #ActionController::InvalidAuthenticityTokenというエラーが出たため記述してみた
    protect_from_forgery

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      #if resource.is_a?(Admin)…resource がAdmin のインスタンスであれば true を返すという処理
      admin_path
      #注文一覧（管理者TOP）画面へ
    else customer_signed_in?
      customers_my_page_path #エンドユーザー側のマイページへ
    end
  end


  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path#管理者ログイン画面へ
    else
      root_path#エンドユーザー側のTOP画面へ
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :encrypted_password,:is_deleted])
  end

end
