class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @items = Item.where(is_active: true).first(4)
  end

  def about
  end

end