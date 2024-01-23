# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Admin.find_or_create_by!(
#    email: 'withbeer@withbeer',
#    password: 'ENV['ADMIN_PASSWORD']'
# )

Admin.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
end

次郎 = Customer.find_or_create_by!(email: "jirou@example.com") do |customer|
  customer.user_name = "次郎"
  customer.password = "password"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename:"sample-customer1.jpg")
end

冬子 = Customer.find_or_create_by!(email: "huyu@example.com") do |customer|
  customer.user_name = "冬子"
  customer.password = "password"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer2.jpg"), filename:"sample-customer2.jpg")
end

道子 = Customer.find_or_create_by!(email: "michiko@example.com") do |customer|
  customer.user_name = "道子"
  customer.password = "password"
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer3.jpg"), filename:"sample-customer3.jpg")
end

Snack.find_or_create_by!(title: "エリンギのガリバタ醤油炒め") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack1.jpg"), filename:"sample-snack1.jpg")
  snack.introduction = "ガーリック・バター・醤油の最強トリオでビールが進む逸品です。"
  snack.customer = 次郎
  snack.ingredients = "
（2人前）
エリンギ（小）：8本
バター：15g にんにくチューブ：3センチ
冷凍いんげん：7~8本
(A)しょうゆ：小さじ1
(A)化学調味料：小さじ1"
  snack.process = "
1. エリンギといんげんを食べやすい大きさにカットします。
2.フライパンを弱火にかけバターを熱します。チューブにんにくをいれバターと炒め合わせます。
3. 中火でエリンギといんげんを炒め、しんなりしたら(A)を加えて味を整えます。"
  snack.sake = Sake.find(1)
end

Snack.find_or_create_by!(title: "グリル野菜のチーズ焼き") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack2.jpg"), filename:"sample-snack2.jpg")
  snack.introduction = "赤ワインとの相性抜群！ぜひお試しください。"
  snack.customer = 冬子
  snack.ingredients = "
（2人前）
グリル野菜ミックス（冷凍）：1袋
舞茸：半パック
とろける：チーズ2枚
粉チーズ：大さじ1
にんにくチューブ：3センチ
塩コショウ：少々"
  snack.process = "
1. バターとにんにくを中火で、にんにくの香りが出るくらいまで炒めます。
2.野菜ミックス・舞茸を入れます。野菜がしんなりするまで炒めます。
3. 炒めたらグラタン皿に取り分けて、スライスチーズを上に乗せます。さらにその上から粉チーズをかけます。
4. オーブントースターで5分焼き、焦げ目がついたら完成です。"
  snack.sake = Sake.find(2)
end

Snack.find_or_create_by!(title: "野菜たっぷり天ぷら") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack3.jpg"), filename:"sample-snack3.jpg")
  snack.introduction = "野菜盛りだくさんの天ぷら！！ビールが進むこと間違いなし！！！"
  snack.customer = 道子
  snack.ingredients = "
（3人前）
鳥ササミ：150g
ししとう：1パック
レンコン：1個
舞茸：1パック
ジャガイモ：1個
エビ：6尾
A（ニンニクチューブ：3センチ
生姜チューブ：3センチ
酒：大さじ1
醤油：大さじ1
水：大さじ1）
サラダ油：適量
天ぷら粉：200g
【下準備】エビ：殻とって背腸を取る　レンコン：1センチ程度に切って輪切りの状態で酢水にさらす　舞茸：適当な大きさに分けるジャガイモ：皮を剥いて1センチ輪切り"
  snack.process = "
1. 天ぷら粉を水で溶きます。
2.野菜から順番に水で溶いた天ぷら粉につけて油で揚げます。
3. 全部揚げたら完成です。"
  snack.sake = Sake.find(1)
end