class Order < ApplicationRecord

  #Gemfileにenum_help導入の記述後、
  #enumを実際に定義(モデルに記述)し、数字と文字列を紐づけする
  enum payment_method: { credit_card: 0, transfer: 1 }

  #アソシエーション：customerとorder(1:Nの関係)を関連付ける
  belongs_to :customer
  #アソシエーション：orderとorder_detail(1:Nの関係)を関連付ける
  has_many :order_details, dependent: :destroy

  #status:注文ステータスの設定のために記述
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }


end
