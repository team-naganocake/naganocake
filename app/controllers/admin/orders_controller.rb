class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
  #ステータス関連後回し
  #   @order = Order.find(params[:id])
  #   @order_details = OrderDetail.where(order_id: params[:id])
  # if @order.update(order_params)
  #   @order_details.update_all(production_pending: 1) if @order.status == "payment_confirmation"
  #   ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
  # end
  #   redirect_to admin_order_path(@order.id)
  end

  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
