class Public::CartItemsController < ApplicationController

  def create
    @cart_item = CartItem.new(cart_items_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
    #同一商品が存在する場合の処理をあとでここに書く
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_items_params)
    redirect_to cart_items_path
    #destroyしたときのupdateもあとでここに書く
  end

  def index
    @cart_item = CartItem.new
    @customer = current_customer
    @cart_items = @customer.cart_items
    
    @total = 0 
    #カート内の合計金額を出すために入れ物作成(数字だけ入るように)
  end


  def destroy
    
  end

  def destroy_all
  end

   #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  def cart_items_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end

end