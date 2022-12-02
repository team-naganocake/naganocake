class Address < ApplicationRecord
  #public/addressesコントローラーでのアソシエーション設定
  # belongs_to :customer→これ書くとadress#indexで新規投稿できなくなる

end
