class CartItem < ApplicationRecord
  #ActiveStorageを使って画像を表示する
  has_one_attached :image

  #アソシエーション：customerとcart_item(1:Nの関係)を関連付ける
  belongs_to :customer
  #アソシエーション：itemとcart_item(1:Nの関係)を関連付ける
  belongs_to :item


  #小計を求めるメソッド
  def subtotal
    item.with_tax_price*amount
  end

end
