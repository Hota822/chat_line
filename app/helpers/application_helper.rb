module ApplicationHelper

  #引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(user, options={ size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  #トークルームの最新のトークを返す
  def get_latest_talk(talk_room, options={ sentence: 1 })
    sentence = options[:sentence]
    talk_room.talks.first(sentence)
  end

end
