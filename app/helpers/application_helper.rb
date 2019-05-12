module ApplicationHelper

  #引数で与えられたユーザーのGravatarがぞうを返す
  def gravatar_for(user, options={ size: 80})
    user ||=  current_user
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
