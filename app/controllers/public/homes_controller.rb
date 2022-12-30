class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    #@items = Item.where(is_active: true).first(4)
    @items = Item.where(is_active: true).order('id DESC').limit(4)
    #これで新着4件（販売中のみ）が表示されるようになった
  end

  def about
  end

end