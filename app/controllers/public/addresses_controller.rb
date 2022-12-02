class Public::AddressesController < ApplicationController

  def create
    @address = Address.new
    @address = Address.new(address_params)
    @customer = current_customer
    @address.save
    redirect_to addresses_path #同じ画面のまま(public/addresses#index)
  end

  def index
    @addresses = Address.all
    @customer = current_customer
    @address = Address.new
  end

  def destroy
  end

  def edit
  end

  def update
  end



  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)

  end
end