class Item < ApplicationRecord
  #ActiveStorageを使って画像を表示する
  has_one_attached :image

  #アソシエーション：genreとitem(1:Nの関係)を関連付ける
  belongs_to :genre
  #アソシエーション：itemとcart_item(1：Nの関係)を関連付ける
  has_many :cart_items, dependent: :destroy
  #アソシエーション：itemとorder_detail(1:Nの関係)を関連付ける
  has_many :order_details, dependent: :destroy

  #public/items#indexの1ページあたりの表示件数を8件にするために追記
  paginates_per 8


  #消費税を求めるメソッド
  def with_tax_price
    (price*1.1).floor
  end

end
