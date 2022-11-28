class Admin::GenresController < ApplicationController

  def create
    @genre = Genre.new
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path#同じ画面のまま
  end

  def index
    @genres = Genre.all
  end

  def edit
  end

  def update
  end

  #privateは記述をしたコントローラ内でしか参照できない
  #protectedは呼び出された他のコントローラーからも参照することができる
  protected

  #ここに書いたカラム情報を取得してもいいという許可。実際に受け取っているわけではなくあくまでも許可の指示。
  def genre_params
    params.require(:genre).permit(:name)
  end
end
