class Order < ApplicationRecord

  #Gemfileにenum_help導入の記述後、
  #enumを実際に定義(モデルに記述)し、数字と文字列を紐づけする
  enum payment_method: { credit_card: 0, transfer: 1 }

end
