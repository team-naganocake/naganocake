class Item < ApplicationRecord
  #ActiveStorageを使って画像を表示する
  has_one_attached :image

end
