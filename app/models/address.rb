class Address < ApplicationRecord
  #アソシエーション：customerとaddress(1:N)を関連付ける
  belongs_to :customer

  #表示部分には「郵便番号 住所 宛名」を表示する必要がある。
  #しかし、テキストに表示する部分にはメソッドを入れる必要があるため、
  #options_from_collection_for_select に直接「郵便番号 住所 宛名」を書くことはできないので
  #これらを表示するためのメソッドを配送先(Address)モデルに記述する
  def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
  end

end
