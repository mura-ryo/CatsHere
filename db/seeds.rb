# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@admin.com',
  password: 'admin555',
)

users = User.create!(
  [
    {email: 'kanji@test.com', name: '貫児', password: 'password',
    introduction: '貫児、74歳。今はブログを書いています。趣味は写真撮影です。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user1.jpg"), filename:"user1.jpg")},

    {email: 'toshie@test.com', name: 'としえです', password: 'password',
    introduction: 'よろしくお願いします。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user2.jpg"), filename:"user2.jpg")},

    {email: 'miyoko@test.com', name: 'よこよこ', password: 'password',
    introduction: 'こんにちわ、よこよこです。我が家に猫がやってきたので始めまてみました。よろしくお願いします。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user3.jpg"), filename:"user3.jpg")},

    {email: 'yukie@test.com', name: 'ゆきえ', password: 'password',
    introduction: 'はじめましてゆきえです。うちのアイドルを皆さんにもぜひ見ていただきたいです。よろしくお願いします。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user4.jpg"), filename:"user4.jpg")},

    {email: 'george@test.com', name: 'ジョージ', password: 'password',
    introduction: 'みんなの笑顔が宝物！ジョージです！', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user5.jpg"), filename:"user5.jpg")},

    {email: 'hiroshi@test.com', name: 'Hiroshi', password: 'password',
    introduction: '妻と娘と猫と４人で暮らしてるひろしと申します。気ままに投稿したいと思います。', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user6.jpg"), filename:"user6.jpg")},
  ]
)

Post.create!(
  [
    {title: '森の妖精', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post1.jpg"), filename:"post1.jpg"),
     body: 'ある日、公園に出かけてみると空を眺めている猫がいたので、撮影してみました。', user_id: users[0].id },

    {title: 'みんなの人気もの', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post2.jpg"), filename:"post2.jpg"),
     body: 'こんにちわ、としえです。この子はみんなの人気者のみーちゃんです。かわいい姿にいつもみんな癒されています。', user_id: users[1].id },

    {title: '新しい家族！', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post3.jpg"), filename:"post3.jpg"),
     body: 'この度我が家に新しい家族を迎えました！名前はちょろです。どんな雰囲気に育っていくのかとても楽しみです。これからよろしくね。', user_id: users[2].id },

    {title: '今日の一枚', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post4.jpg"), filename:"post4.jpg"),
     body: '我が家のアイドル。今日の一枚をとってみました。', user_id: users[3].id },

    {title: '助けて～', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post5.jpg"), filename:"post5.jpg"),
     body: '本日は定期健診です。お医者さんから逃げるうちのねこちゃんを撮影してみました。', user_id: users[5].id },

    {title: 'ハロウィンだね', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post6.jpg"), filename:"post6.jpg"),
     body: '我が家のアイドル。ハロウィン仕様の衣装です。かわいいかな？', user_id: users[3].id },

    {title: 'ねこ？', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post7.jpg"), filename:"post7.jpg"),
     body: 'すみません。トラです笑。たまたま動物園に来たので撮影しました。猫と似たかわいさもありますよね？', user_id: users[4].id },

    {title: '仕事中', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post8.jpg"), filename:"post8.jpg"),
     body: '仕事が終わらない！！（写真と関係ない）早く写真撮影しに行きたいな～', user_id: users[0].id },

    {title: 'ごはんがないっ！', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post9.jpg"), filename:"post9.jpg"),
     body: 'ごはんを食べようと思ったら、何もなかった時の表情がかわいかったので、撮影してみました。', user_id: users[5].id },

    {title: '入りたくない', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post10.jpg"), filename:"post10.jpg"),
     body: 'この箱には嫌な思い出があるようですね。嫌な顔して覗いています。', user_id: users[5].id },

    {title: 'ごめんなさい！！', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post11.jpg"), filename:"post11.jpg"),
     body: '近所を散歩してたらこわもてのお兄さんがっ！チュールお渡しするので勘弁してください！', user_id: users[4].id },

    {title: '娘と猫', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post12.jpg"), filename:"post12.jpg"),
     body: '娘と猫がくつろいでいたので撮影してみました。猫がいるだけで家庭が和みますね。', user_id: users[5].id }
  ]
)