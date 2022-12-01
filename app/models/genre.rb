class Genre < ApplicationRecord
  #genreとitem(1:Nの関係)を関連付ける（アソシエーション）
  has_many :items, dependent: :destroy

end
