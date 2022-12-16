class OrderDetail < ApplicationRecord

  #アソシエーション：orderとorder_detail(1:Nの関係)を関連付ける
  belongs_to :order
  #アソシエーション：itemとorder_detail(1:Nの関係)を関連付ける
  belongs_to :item

end
