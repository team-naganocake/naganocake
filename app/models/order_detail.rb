class OrderDetail < ApplicationRecord

  #アソシエーション：orderとorder_detail(1:Nの関係)を関連付ける
  belongs_to :order
  #アソシエーション：itemとorder_detail(1:Nの関係)を関連付ける
  belongs_to :item

  #making_status：製作ステータスのために記述
  enum making_status: { production_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3 }

end
