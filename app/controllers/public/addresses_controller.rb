class Public::AddressesController < ApplicationController

  def create
    #@address = Address.new #いらない（createアクションでこれは使わない）
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path #同じ画面のまま(public/addresses#index)
  end

  def index
    @addresses = Address.where(customer_id: current_customer.id)
    #idを指定して取り出したい時は↑こういう書き方になる
    #address.allって書いたら絶対ダメ。前会員の情報が表示されることになっちゃう
    @customer = current_customer
    @address = Address.new
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path #同じ画面のまま(public/addresses#index)
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path#public/addresses#intex
    else
      render :edit
    end
  end



  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :customer_id)

  end
end
