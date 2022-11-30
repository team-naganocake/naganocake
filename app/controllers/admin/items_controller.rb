class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
    #flash[:notice] ="Product was successfully created"
    redirect_to admin_items_path(@item.id) #商品詳細へ
    #一旦、ジャンル作成してから商品登録に再挑戦
  end

   def index
    @items = Item.all
    @genres = Genre.all
    @items = Item.page(params[:page])#ページネーション
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path(@item.id)#詳細ページへ
    else
      render :edit
    end
  end


  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end

end
