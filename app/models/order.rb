class Order < ApplicationRecord

  #Gemfileにenum_help導入の記述後、
  #enumを実際に定義(モデルに記述)し、数字と文字列を紐づけする
  enum payment_method: { credit_card: 0, transfer: 1 }

  #アソシエーション：customerとorder(1:Nの関係)を関連付ける
  belongs_to :customer
  #アソシエーション：orderとorder_detail(1:Nの関係)を関連付ける
  has_many :order_details, dependent: :destroy

end
