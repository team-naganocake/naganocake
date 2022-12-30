class Admin::HomesController < ApplicationController

before_action :authenticate_admin!
#コントローラーに設定して、ログイン済管理者のみにアクセスを許可する。これ必要？

  def top
   @orders = Order.all.page(params[:page]).per(4).order('created_at DESC')
  end

end
