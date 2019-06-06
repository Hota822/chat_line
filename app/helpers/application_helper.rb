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

  #content_type == formula のtalkを文字列からHTMLに変換し返す
  def trans_formula_to_html(string)
    before_index = string.index('{')
    unless before_index
      return string
    else
      symbol_header = 3
      after_index = string.rindex('}')
      data_trans_symbol = string[(before_index-symbol_header)..before_index]
      string_before = sting[0..(before_index -symbol_header)]
      string_after = sting[(after_index +1)..(string.length -1)]
      string_middle = trans_symbol_to_html(string[(before_index +1)..(after_index -1)], data_trans_symbol)
      return string_before + string_middle + string_after
    end
  end
  

  #trams_formula_to_htmlでsymoblをhtmlに変換
  def trans_symbol_to_html(string, data_trans_symbol)
    parent_index = string.index('{')
    child_index = string.index('(')



    if string.include?('{')
      #return '<div>' + trans_formula_to_html(string) '</div>'
    else
    end

  end

end
