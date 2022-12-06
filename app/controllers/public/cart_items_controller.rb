class Public::CartItemsController < ApplicationController

  def index
  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
  end


  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  def cart_items_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount, :image)
  end

end
