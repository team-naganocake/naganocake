class Public::AddressesController < ApplicationController

  def index
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
  end



  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
