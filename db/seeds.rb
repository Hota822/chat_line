
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "password",
  password_confirmation: "password")

#ユーザー
99.times do |n|
name  = Faker::Name.name + "#{n}"
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password)
end

#フレンドリクエスト
user = User.find(1)
10.times do |n|
  request_user = User.find(n+2)
  request_user.friend_requests.create(request_user_id: user.id)
end

#フレンド
user = User.find(1)
20.times do |n|
  friend_user = User.find(n+12)
  friend_user.friend_relations_to.create(friend_id: user.id)
end

#トークルーム, トーク
user = User.find(1)
15.times do |n|
  #一対一
  talk_room = TalkRoom.create()
  other_user = User.find(n+12)
  talk_room.invite(user)
  talk_room.invite(other_user)

  5.times do
    content = Faker::Lorem.sentence(5)
    talk_room.talks.create!(user_id: user.id, content: content)
    content = Faker::Lorem.sentence(5)
    talk_room.talks.create!(user_id: other_user.id, content: content)
  end
  #グループ
  if n > 10

    group_talk_room = TalkRoom.create!()
    group_user = User.find(n+13)
    group_talk_room.invite(user)
    group_talk_room.invite(other_user)
    group_talk_room.invite(group_user)
    5.times do
      content = Faker::Lorem.sentence(5)
      group_talk_room.talks.create(user_id: group_user.id, content: content)
    end
  end
end
