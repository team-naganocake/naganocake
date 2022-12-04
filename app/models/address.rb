class Address < ApplicationRecord
  #public/addressesコントローラーでのアソシエーション設定
  belongs_to :customer

end
