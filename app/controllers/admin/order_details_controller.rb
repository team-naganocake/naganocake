class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    #bookersと同じようなイメージ。@book.user/@user.book
    @order_details = @order.order_details.all
    @order_detail.update(order_detail_params)

    if @order_details.where(making_status: "in_production").count >= 1
      @order.status = "in_production"
      @order.save
      #2．製作着手するタイミングで、パティシエが"製作ステータス"を「製作中in_production」と設定する。
      #紐付く注文商品の製作ステータス(making_status)が一つでも「製作中」になったら"注文ステータス(status)"も「製作中」自動更新する。
    end

    if @order_details.count == @order_details.where(making_status: "production_complete").count
       #order_detailの数量を数えて、それを＝＝で右側のと比べてる。数が一致したら、全部変わったことが確認できる。
       #.count→レコード数をカウントする
       @order.status = "preparing_delivery"
       @order.save
       #3.紐付いている注文商品の製作ステータスがすべて[製作完了production_complete]になった際、
       #注文ステータスを自動的に[発送準備中preparing_delivery]にする。
    end
    redirect_to admin_order_path(@order.id)#←確認もう定義済
  end


   #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
