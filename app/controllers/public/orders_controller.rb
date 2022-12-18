class Public::OrdersController < ApplicationController

  #注文情報(支払方法・配送先)入力画面
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = current_customer.addresses.all
  end

  #注文情報確認画面
  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name

    @order.shipping_cost = 800
    @total = 0

    #  [:address_option]=="0"のデータ(customerの住所)を呼び出す
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      #params[:order][:address_option] = "2"elseの横に条件式は書いちゃダメ。ここは全部の受け皿。エラーでる。
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end


  #注文を確定するためのアクション
  #@orderに情報を保存する
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    if @order.save
    #Q、saveとsave!の違い確認
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new(order_id: @order.id)
        #order_item.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.price = cart_item.item.price
        order_detail.amount = cart_item.amount
        order_detail.save
      end
      @cart_items.destroy_all
      redirect_to orders_complete_path
    else
      render "new"
    end
  end


  def complete
  end

  def index
    @orders = current_customer.orders.all.page(params[:page]).per(5).order('created_at DESC')
    # DESCは、降順(新しいものが上)
  end

  def show
  end


  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
