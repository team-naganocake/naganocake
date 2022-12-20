class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def update
  end

  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
