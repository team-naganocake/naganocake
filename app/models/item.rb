class Item < ApplicationRecord
  #ActiveStorageを使って画像を表示する
  has_one_attached :image

  #genreとitem(1:Nの関係)を関連付ける（アソシエーション）
  belongs_to :genre

end
