class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
  #製作ステータス関連
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details

    if @order.status_before_type_cast == 1
      #数値で比較できるようになるbefore～
      #@order.status ==文字列（英語）でもＯＫ
      @order_details.each do |order_detail|
        order_detail.making_status = "production_pending"
        order_detail.save
      ##注文ステータス(staus)が「入金確認(payment_confirmation)」のとき、製作ステータスを全て「製作待ち（production_pending）」に自動更新する
      ##でも変更ボタンは押さなきゃいけない
      end
    end
    redirect_to admin_order_path
    #admin/orders#show
  end



  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
