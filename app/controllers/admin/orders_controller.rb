class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details

    if @order.status_before_type_cast == 1
      #数値で比較できるようになるbefore～
      #@order.status ==文字列（英語）でもＯＫ
      @order_details.each do |order_detail|
        order_detail.making_status = "production_pending"
        order_detail.save
      #1．注文ステータスを[入金待ちpayment_waiting]から[入金確認payment_confirmation]へ更新した際に、
      #製作ステータスを自動的に[着手不可production_not_possible]から[製作待ちproduction_pending]に更新させる。
      #でも更新ボタンは押さなきゃいけない
      end

  #上の省略バージョン。本来はeachでとりだしてる。これでもOK
  #   if @order.status == "payment_confirmation"
  #     # 紐づく注文ステータスが「入金確認」に更新されていたら
  #     @order_details.update_all(making_status: "production_pending")
  #     # 制作ステータスを全商品「製作待ち」に更新
  # 　end

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
