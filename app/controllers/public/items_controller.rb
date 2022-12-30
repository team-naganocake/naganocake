class Public::ItemsController < ApplicationController

  def index
    @items = Item.where(is_active: true).page(params[:page])
    #@items = Item.allに、販売中であるという制約とページネーションを追加
    #1ページあたりの表示件数については、Itemモデルに記述した
    @genres = Genre.all
    if params[:genre_id].present?
      #presentメソッドでparams[:genre_id]に値が含まれているか確認 => trueの場合下記を実行
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_active: true).page(params[:page])
      #@items = @genre.itemsに、販売中であるという制約とページネーションを追加
    else
      @items = Item.where(is_active: true).page(params[:page])
      #@items = Item.allに、販売中であるという制約とページネーションを追加
      #@items = Item.where(is_active: true).order('id DESC').limit(4)

    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end


  #######################################
  # def index
  #   @items = Item.page(params[:page])
  #   #@items = Item.allをページネーション用に書き換え
  #   @genres = Genre.all
  #   if params[:genre_id].present?
  #     #presentメソッドでparams[:genre_id]に値が含まれているか確認 => trueの場合下記を実行
  #     @genre = Genre.find(params[:genre_id])
  #     @items = @genre.items.page(params[:page])
  #     #@items = @genre.itemsをページネーション用に書き換え
  #   end
  # end

  # def show
  #   @item = Item.find(params[:id])
  #   @genres = Genre.all
  # end


  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_active, :image)
  end
end