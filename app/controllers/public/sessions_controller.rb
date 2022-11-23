# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
# ★before actionを設定し、public/session_controllerのcreateアクション（顧客のログイン機能）アクションが実行される前に確認を行う。
#退会していなかった場合,createアクション（顧客のログイン機能）を実行させる
  before_action :customer_state, only: [:create]


  # before_action :configure_sign_in_params, only: [:create]

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected

# 退会しているかを判断するメソッド
  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    #入力されたemailからアカウントを1件取得
    return if !@customer
    #アカウントを取得できなかった場合、このメソッドを終了(createに戻るだけ。新規登録には戻らない。)
    #そもそもemailがヒットしなければ、退会どころか、そもそも登録したこともない
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == true
    #「取得したアカウントのパスワードと入力されたパスワードが一致しているかを判別」かつ「退会済」だった場合
    #.valid_password?…　「？」があるメソッドは、自動的にtrueとfalseが認識される。だからあえて＝＝trueなどを書く必要はない
    #.valid_password?の部分が、trueでもfalseでも、「.is_deleted == true」の場合は新規登録に戻る必要がある。
    redirect_to new_customer_registration_path
    end
  end


end
