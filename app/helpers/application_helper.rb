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
    @counter = 0
    @counter_string = ''
    #raise
    divide_string(string)
  end


  #aaafrc{frc_t(bbb]frc_b(cc]}ddd  => a b/c d
  #aaaafrc{frc_t(bfrc{frc_t(eee]frc_b(fffff]}bb]frc_b(ccc]}ddd  a (b e/f bb) dd
  #aafrc2{t(bb]b(ccfrc2{t(dd]b(ee]}]}
  #"frc2{t(a]b(b]}dir( ＋ frc2{t(a]b(c]}]"
  def divide_string(string)
    return '' unless string
    before_index = string.index('{')
    unless before_index
      return add_division(string, 'input_area')
    else
      symbol_header = 4 #header_string + inner_element_number
      after_index = string.index('}')
      if string[(before_index +1)..after_index].include?('{')
        #ネストされたsymbolを含む場合
        index_count = string[(before_index +1)..after_index].count('{')
        for i in 1..index_count
          after_index = string.index('}', after_index +1)
        end
      else
        #ネストされたsymbolを含まない場合、そのまま実行可能
      end
      data_trans_symbol = string[(before_index -symbol_header)..before_index]
      if before_index -symbol_header == 0
        string_before = ''
      else
        string_before = add_division(string[0..(before_index -symbol_header -1)], 'input_area')
      end
      if after_index +1 == string.length
        string_after = ''
      else
        string_after = divide_string(string[(after_index +1)..((string.length) -1)])
      end
      ##raise
      string_middle = trans_symbol_to_html(string[(before_index +1)..(after_index -1)],
                                            data_trans_symbol[0..2],
                                            data_trans_symbol[3])
      return string_before + add_division(string_middle, 'parent') + string_after
    end
  end

  def trans_symbol_to_html(string, data_trans_symbol, inner_value)
    return_string = ''
    tag_end = nil
    if string.include?('{')
      #ネストしていた場合、それを先にHTML変換
      string = divide_string(string)
      category = 'parent'
    else
      category = 'child'
    end
    #raise
    for i in 1..inner_value.to_i do
      add_string = ''
      before_index = string.index('(')
      after_index = string.index(']')
      case data_trans_symbol
      when 'frc'
        return_string += '<hr>' if i == 2
      when 'igl'
        return_string += add_container if i == 2
        tag_end ||= true
      end
      child_class = "#{data_trans_symbol}_#{i.ordinalize}"
      add_string = string[(before_index +1)..(after_index -1)] unless string == ''
      return_string += add_division(add_string, "#{category} #{child_class}")
      string = string[(after_index +1)..((string.length) -1)]
    end
    return_string += '</div>' if tag_end
    return_string
  end

  def add_division(string, class_value=nil)
    class_value = " class=\'#{class_value}\'" if class_value
    return "<div#{class_value}>" + string + '</div>'
  end

  def add_container
    return '<div class="symbol_container">'
  end
end
