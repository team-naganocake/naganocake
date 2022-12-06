class Address < ApplicationRecord
  #アソシエーション：customerとaddress(1:N)を関連付ける
  belongs_to :customer

end
