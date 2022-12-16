class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #アソシエーション：customerとaddresses(1：N)を関連付ける
  has_many :addresses, dependent: :destroy
  #アソシエーション：customerとcart_item(1:N)を関連付ける
  has_many :cart_items, dependent: :destroy
  #アソシエーション：customerとorder(1:N)を関連付ける
  has_many :orders, dependent: :destroy


end
