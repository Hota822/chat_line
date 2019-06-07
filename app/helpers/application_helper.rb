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
    #小文字の<等を削除
    divide_string(string)
  end


  #aaafrc{frc_t(bbb]frc_b(cc]}ddd  => a b/c d
  #aaaafrc{frc_t{bfrc{frc_t(eee]frc_b(fffff]}bb}frc_b(ccc]}ddd a (b e/f bb) dd
  #aaaafrc{frc_t(bfrc{frc_t(eee]frc_b(fffff]}bb]frc_b(ccc]}ddd 
  def divide_string(string)
    before_index = string.index('{')
    unless before_index
      return add_division(string, 'input_area')
    else
      symbol_header = 4
      after_index = string.rindex('}')
      data_trans_symbol = string[(before_index -symbol_header)..before_index]
      if before_index -symbol_header == 0
        string_before = ''
      else
        string_before = add_division(string[0..(before_index -symbol_header -1)], 'input_area')
      end
      if after_index +1 == string.length
        string_after = ''
      else
        string_after = add_division(string[(after_index +1)..((string.length) -1)], 'input_area')
      end
      string_middle = trans_symbol_to_html(string[(before_index +1)..(after_index -1)],
                                            data_trans_symbol[0..2],
                                            data_trans_symbol[3])
      return string_before + add_division(string_middle, 'parent') + string_after
    end
  end
  
 #aaafrc{frc_t(bbb]frc_b(cc]}ddd  => a b/c d
  #aaaafrc{frc_t{bfrc{frc_t(eee]frc_b(fffff]}bb}frc_b(ccc]}ddd a (b e/f bb) dd
  #aaaafrc{frc_t(bfrc{frc_t(eee]frc_b(fffff]}bb]frc_b(ccc]}ddd 
  #trams_formula_to_htmlでsymoblをhtmlに変換
  def trans_symbol_to_html(string, data_trans_symbol, inner_value)
    return_string = ''
    string = divide_string(string) if string.include?('{')
    for i in 1..inner_value.to_i do
      end_index = string.index(']')
      return_string += add_division(string[2..(end_index -1)], 'symbol')
      case data_trans_symbol
      when 'frc'
        return_string += '<hr>' if i == 1
      end
      string = string[(end_index +1)..((string.length) -1)]
    end
    return_string
  end

  def add_division(string, class_value=nil)
    class_value = " class=#{class_value}" if class_value
      return "<div#{class_value}>" + string + '</div>'
  end
end