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

Sake.create([
  { genre: 'ビール' },
  { genre: '赤ワイン' },
  { genre: '白ワイン' },
  { genre: '日本酒' },
  { genre: '焼酎' }
])

次郎 = Customer.find_or_create_by!(email: ENV['CUSTOMER1_EMAIL']) do |customer|
  customer.user_name = "次郎"
  customer.introduction = "三度の飯よりお酒が好き"
  customer.password = ENV['CUSTOMER1_PASSWORD']
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer1.jpg"), filename:"sample-customer1.jpg")
end

冬子 = Customer.find_or_create_by!(email: ENV['CUSTOMER2_EMAIL']) do |customer|
  customer.user_name = "冬子"
  customer.introduction = "赤ワインが大好きです。赤ワインに合うおつまみを紹介していきたいと思います。"
  customer.password = ENV['CUSTOMER2_PASSWORD']
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer2.jpg"), filename:"sample-customer2.jpg")
end

道子 = Customer.find_or_create_by!(email: ENV['CUSTOMER3_EMAIL']) do |customer|
  customer.user_name = "道子"
  customer.introduction = "no BEER no life"
  customer.password = ENV['CUSTOMER3_PASSWORD']
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer3.jpg"), filename:"sample-customer3.jpg")
end

サブロー = Customer.find_or_create_by!(email: ENV['CUSTOMER4_EMAIL']) do |customer|
  customer.user_name = "サブロー"
  customer.password = ENV['CUSTOMER4_PASSWORD']
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer4.jpg"), filename:"sample-customer4.jpg")
end

なっちゃん = Customer.find_or_create_by!(email: ENV['CUSTOMER5_EMAIL']) do |customer|
  customer.user_name = "なっちゃん"
  customer.password = ENV['CUSTOMER5_PASSWORD']
  customer.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-customer5.jpg"), filename:"sample-customer5.jpg")
end

Snack.find_or_create_by!(title: "エリンギのガリバタ醤油炒め") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack1.jpg"), filename:"sample-snack1.jpg")
  snack.introduction = "ガーリック・バター・醤油の最強トリオでビールが進む逸品です。"
  snack.customer = 次郎
  snack.ingredients =
"（2人前）
エリンギ（小）：8本
バター：15g
にんにくチューブ：3センチ
冷凍いんげん：7~8本
(A)しょうゆ：小さじ1
(A)化学調味料：小さじ1"
  snack.process =
"1. エリンギといんげんを食べやすい大きさにカットします。
2.フライパンを弱火にかけバターを熱します。チューブにんにくをいれバターと炒め合わせます。
3. 中火でエリンギといんげんを炒め、しんなりしたら(A)を加えて味を整えます。"
  snack.sake = Sake.find(1)
  snack.tags << Tag.find_or_create_by!(name: "和食")
  snack.tags << Tag.find_or_create_by!(name: "こってり")
  snack.tags << Tag.find_or_create_by!(name: "15分以内")
end

Snack.find_or_create_by!(title: "グリル野菜のチーズ焼き") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack2.jpg"), filename:"sample-snack2.jpg")
  snack.introduction = "赤ワインとの相性抜群！ぜひお試しください。"
  snack.customer = 冬子
  snack.ingredients =
"（2人前）
グリル野菜ミックス（冷凍）：1袋
舞茸：半パック
とろけるチーズ:2枚
粉チーズ：大さじ1
にんにくチューブ：3センチ
塩コショウ：少々"
  snack.process =
"1. バターとにんにくを中火で、にんにくの香りが出るくらいまで炒めます。
2.野菜ミックス・舞茸を入れます。野菜がしんなりするまで炒めます。
3. 炒めたらグラタン皿に取り分けて、スライスチーズを上に乗せます。さらにその上から粉チーズをかけます。
4. オーブントースターで5分焼き、焦げ目がついたら完成です。"
  snack.sake = Sake.find(2)
  snack.tags << Tag.find_or_create_by!(name: "洋食")
end

Snack.find_or_create_by!(title: "野菜たっぷり天ぷら") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack3.jpg"), filename:"sample-snack3.jpg")
  snack.introduction = "野菜盛りだくさんの天ぷら！！ビールが進むこと間違いなし！！天つゆで食べても塩で食べても最高に美味しい！！！"
  snack.customer = 道子
  snack.ingredients =
"（3人前）
鳥ササミ：150g
ししとう：1パック
レンコン：1個
舞茸：1パック
ジャガイモ：1個
エビ：6尾
サラダ油：適量
天ぷら粉：200g

A（ニンニクチューブ：3センチ
生姜チューブ：3センチ
酒：大さじ1
醤油：大さじ1
水：大さじ1）

【下準備】
鳥ササミ：揚げる直前までAに漬けておく
エビ：殻を取り背腸を取る
レンコン：1センチ程度に切って輪切りの状態で酢水にさらす
舞茸：適当な大きさに分ける
ジャガイモ：皮を剥いて1センチの輪切りにする"
  snack.process =
"1. 天ぷら粉を水で溶きます。
2. 野菜から順番に水で溶いた天ぷら粉につけて油で揚げます。
　　※ししとうを揚げる際は、油ハネに特に注意してください。
3. 全部揚げたら完成です。

【POINT】
天ぷらが残ったら、次の日に天丼として食べてもいいですね！"
  snack.sake = Sake.find(1)
  snack.tags << Tag.find_or_create_by!(name: "和食")
end

Snack.find_or_create_by!(title: "定番！生姜焼き") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack6.jpg"), filename:"sample-snack6.jpg")
  snack.introduction = "お肉＝赤ワインと思われがちですが、実は白ワインにもとっても合います！ぜひ、白ワインのお供にお試しください。"
  snack.customer = 冬子
  snack.ingredients =
"（2人前）
豚ロース（生姜焼き用）：8枚
市販の生姜焼きのタレ：100g

【付け合わせ】
玉ねぎ：1個
もやし：200g
舞茸：1パック

【下準備】
豚ロース：食べやすい大きさに切る
玉ねぎ：1センチ幅にくし切りする
舞茸：食べやすい大きさに分ける"
  snack.process =
"1. 鍋にサラダ油小さじ1を入れ、豚ロースを焼きます。
2. 焼き色がついたらタレ入れ絡めます。
3. 焦げ目がつくぐらいまで焼いたら、お肉をお皿に取り出します。
4. 付け合わせの野菜を鍋に入れ、残ったタレで炒めます。
5. 野菜にタレが染み込み、しんなりしたらお皿に盛り、出来上がりです。
6. お好みでマヨネーズと七味をかけても美味しいです。"
  snack.sake = Sake.find(3)
  snack.tags << Tag.find_or_create_by!(name: "和食")
  snack.tags << Tag.find_or_create_by!(name: "こってり")
  snack.tags << Tag.find_or_create_by!(name: "簡単")
end

Snack.find_or_create_by!(title: "ピーマンの肉詰め") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack7.jpg"), filename:"sample-snack7.jpg")
  snack.introduction =
  "みんな大好きピーマンの肉詰め！！
お酒のおつまみとしても最高に合います！！
お酒も肉詰めもどちらも進むこと間違いなし！！"
  snack.customer = 次郎
  snack.ingredients =
"（2人前）
ピーマン：4個
合い挽き肉：150g
片栗粉：大さじ1
サラダ油：大さじ1/2

A（玉ねぎ：1/4個
　　片栗粉・酒：各小さじ2
　　塩コショウ：各少々）

B（ケチャップ：大さじ1
　　水・ウスターソース：各大さじ2）

【下準備】
玉ねぎ：みじん切りにする
ピーマン：縦半分に切って種とわたをとる"
  snack.process =
"1. ピーマンに片栗粉をふります。
2. ボウルでひき肉とAを混ぜて肉だねを作り、ピーマンの数に合わせて分け、ピーマンにぎゅうぎゅうにつめます。
【POINT】
焼くときに肉だねが縮み、ピーマンから出てしまうこともあるので、ぎゅうぎゅうに詰めておいてください。
3. フライパンにサラダ油を入れて中火で熱し、2の肉だねを下にした状態で焼きます。焼き色がついたら裏返し、ふたをして弱火で4~5分蒸し焼きにします。
4. 余分な油を拭き取り、Bを加えて煮絡めます。
5. お皿に盛り完成です。"
  snack.sake = Sake.find(2)
  snack.tags << Tag.find_or_create_by!(name: "洋食")
  snack.tags << Tag.find_or_create_by!(name: "こってり")
end

Snack.find_or_create_by!(title: "舞茸とチーズのベーコン巻き") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack4.jpg"), filename:"sample-snack4.jpg")
  snack.introduction = "定番のベーコン＆チーズに、舞茸を加えた”THEおつまみ”な逸品です。ビールのお供にお試しください。"
  snack.customer = nil
  snack.ingredients =
"（2人前）
舞茸：１パック
スティックチーズ：10本
ベーコン：10枚
しょうゆ：小さじ1
塩コショウ：少々
サラダ油：適量
【下準備】
1. 舞茸を適当な大きさに分けます。
2. ベーコンにスティックチーズと舞茸を乗せて巻きます。
【POINT】
巻き終わったベーコンの端を下にした状態で、横からつまようじを刺しておくと焼くときに型崩れしにくい！"
  snack.process =
"1. フライパンにサラダ油を敷いてベーコン巻きを中火で炒め、塩コショウをし醤油をかけます。
2. フライパンに蓋をして少々蒸らします。
3. チーズがとろけてきたらお皿に取りわけ完成です。"
  snack.sake = Sake.find(1)
  snack.tags << Tag.find_or_create_by!(name: "和食")
  snack.tags << Tag.find_or_create_by!(name: "簡単")
end

Snack.find_or_create_by!(title: "肉じゃが") do |snack|
  snack.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-snack5.jpg"), filename:"sample-snack5.jpg")
  snack.introduction = "定番のおかずメニューですが、日本酒との相性バッチリです！！ぜひ、日本酒のお供にお試しください。"
  snack.customer = nil
  snack.ingredients =
"（2人前）
じゃがいも：3個
玉ねぎ：1個
豚バラ：250g
白滝：1袋
冷凍いんげん：5本

A（すき焼きのタレ：150ml
水：500ml
砂糖：大さじ2
醤油：50ml）

【下準備】
じゃがいも：四つ切りにする
玉ねぎ：1センチ幅にくし切りする
豚バラ：食べやすい大きさに切る
白滝：食べやすい大きさに切る
いんげん：3センチくらいに切る"
  snack.process =
"1. 鍋にサラダ油小さじ1を入れ、豚バラを炒め、色がついてきたらじゃがいも、玉ねぎ、白滝を入れて炒めます。
2. 1にAを加えます。
3. 蓋をして中火で30分煮ます。（都度あくを取る）
4. いんげんを入れてさらに5分ほど煮ます。
5. じゃがいもに箸を刺し、柔らかくなったと感じたらお皿に盛って出来上がりです。
6. お好みで七味をかけても美味しいです。"
  snack.sake = Sake.find(4)
  snack.tags << Tag.find_or_create_by!(name: "和食")
  snack.tags << Tag.find_or_create_by!(name: "こってり")
end