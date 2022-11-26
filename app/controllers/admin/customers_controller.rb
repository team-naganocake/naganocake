class Admin::CustomersController < ApplicationController

  def index
    @customers = Customer.all.page(params[:page])#ページネーション
  end

  def show
    @customer = Customer.find(params[:id])
    #ここではレコードを1件だけ取得するので、インスタンス変数名は単数形の「@customer」にした。
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_path(@customer.id)#会員詳細へ
  end



  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

end