# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#ネットで調べたらAdminのアカウント作成方法がのっていたが、最初のログイン時は特にこのような記述はしていなかった。
#これは書いた方がいいのか？これは必要！！！これ書かないとログインできない。
Admin.create!(
    email: 'admin@test.com',
    password: 'admintest',
)