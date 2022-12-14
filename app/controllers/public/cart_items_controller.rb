class Public::CartItemsController < ApplicationController

  def create
    #【カート商品を追加・保存】
  #customerがログインしていない時はカートに商品いれられない。
  #ここで記述することも出来るし、html(public/item#show)に書くことも出来る←これはボタンを表示させない方法
  #   unless customer_sign_in?(サインインしていなければ…)
  #     redirect_to ログインページへのパス

    @cart_item_new = CartItem.new(cart_items_params)
    @cart_item_new.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       #もともとカート内にあるもの「item_id」
       #今追加したもの　　　　　　 params[:cart_item][:item_id]
       @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       @cart_item.amount = @cart_item.amount + params[:cart_item][:amount].to_i
       #省略version：cart_item.amount += params[:cart_item][:amount].to_i
       #cart.item.amountに今追加したparams[:cart_item][:amount].to_iを加える
       #フォームから送られてきたデータはすべて文字列型
       #加算などの演算に用意る場合は.to_iを使い文字列型→数字型に変換する必要がある
       @cart_item.save
       redirect_to cart_items_path
    #【もしカート内に「同じ」商品がない場合は通常の保存処理】
    else
      @cart_item_new.save
      redirect_to cart_items_path
    end
    #ここにまとめてredirect処理書いてもいい
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
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path#public/cart_items#indexへ
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path#public/cart_items#indexへ
  end


   #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  def cart_items_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end