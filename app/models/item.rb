class Item < ApplicationRecord
  #ActiveStorageを使って画像を表示する
  has_one_attached :image

  #アソシエーション：genreとitem(1:Nの関係)を関連付ける
  belongs_to :genre

  #アソシエーション：itemとcart_item(1：Nの関係)を関連付ける
  has_many :cart_items, dependent: :destroy

end
