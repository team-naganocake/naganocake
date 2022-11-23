class Public::CustomersController < ApplicationController
  def show
    #@user = User.find(params[:id])
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_page_path
    else
      render :edit
    end
  end

  #退会確認画面用のアクション
  def unsubscribe
    @customer = current_customer
  end

  #退会のアクション
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true) #ここでis_deletedカラムの値をtrue(退会済）に更新
    reset_session #この記述で現在のログイン状況をリセットする（destroyではない）
    # flash[:notice] = "退会が完了しました。他に記載が必要だと思う。とりあえず後回し"
    redirect_to root_path #処理完了後ルートパスへ遷移
  end

  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end


end
