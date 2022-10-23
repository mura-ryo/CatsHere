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
    {email: 'kanji@test.com', name: '貫児', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user1.jpg"), filename:"user1.jpg")},
    {email: 'toshie@test.com', name: 'としえです', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user2.jpg"), filename:"user2.jpg")},
    {email: 'miyoko@test.com', name: 'よこよこ', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user3.jpg"), filename:"user3.jpg")},
    {email: 'yukie@test.com', name: 'ゆきえ', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user4.jpg"), filename:"user4.jpg")},
    {email: 'george@test.com', name: 'ジョージ', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user5.jpg"), filename:"user5.jpg")},
    {email: 'hiroshi@test.com', name: 'Hiroshi', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/user6.jpg"), filename:"user6.jpg")},
  ]
)

Post.create!(
  [
    {title: '森の妖精', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post1.jpg"), filename:"post1.jpg"),
     body: 'ある日、公園に出かけてみると空を眺めている猫がいたので、撮影してみました。', user_id: users[0].id },
    {title: 'みんなの人気もの', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post2.jpg"), filename:"post2.jpg"),
     body: 'こんにちわ、としえです。この子はみんなの人気者のみーちゃんです。かわいい姿にいつもみんな癒されています。', user_id: users[1].id },
    {title: '新しい家族！', image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/post3.jpg"), filename:"post3.jpg"),
     body: 'この度我が家に新しい家族を迎えました！名前はちょろです。どんな雰囲気に育っていくのかとても楽しみです。これからよろしくね。', user_id: users[2].id }
  ]
)