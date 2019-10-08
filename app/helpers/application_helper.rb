# frozen_string_literal: true

# for all application
module ApplicationHelper
  # return Gravatar image by passed argument user
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  # return latest talk in the talk_room
  def get_latest_talk(talk_room, options = { sentence: 1 })
    sentence = options[:sentence]
    talk_room.talks.first(sentence)
  end

  # translate from string to html (content_type == formula)
  # when render each talk (_talk.html), this is used first
  def trans_formula_to_html(string)
    # delete downcase of '<', etc is required
    @counter = 0
    @counter_string = ''
    # raise
    divide_string(string)
  end

  private

  def add_division(string, class_value = nil)
    class_value = " class=\'#{class_value}\'" if class_value
    "<div#{class_value}>" + string + '</div>'
  end

  def add_container
    '<div class="symbol_container">'
  end

  # aaafrc{frc_t(bbb]frc_b(cc]}ddd  => a b/c d
  # aaaafrc{frc_t(bfrc{frc_t(eee]frc_b(fffff]}bb]frc_b(ccc]}ddd  a (b e/f bb) dd
  # aafrc2{t(bb]b(ccfrc2{t(dd]b(ee]}]}
  # "frc2{t(a]b(b]}dir( + frc2{t(a]b(c]}]"
  def divide_string(string)
    return '' unless string # when no message was entered

    # no symbols was entered
    before = string.index('{')
    return add_division(string, 'input_area') unless before

    after = check_nest(string, before, string.index('}'))
    header = 4 # header_string + inner_element_number

    make_string(string, before, after, header)
  end

  def check_nest(string, before, after)
    return after unless string[(before + 1)..after].include?('{')

    # when include nested symbol
    index_count = string[(before + 1)..after].count('{')
    index_count.times { after = string.index('}', after + 1) }
  end

  def make_string(string, before, after, header)
    data_trans_symbol = string[(before - header)..before]
    string_before = make_before_string(string, before, header)
    string_after = make_after_string(string, after)
    string_middle = trans_symbol_to_html(string[(before + 1)..(after - 1)],
                                         data_trans_symbol[0..2],
                                         data_trans_symbol[3])
    string_before + add_division(string_middle, 'parent') + string_after
  end

  def make_before_string(string, before, header)
    if (before - header).zero?
      ''
    else
      add_division(string[0..(before - header - 1)], 'input_area')
    end
  end

  def make_after_string(string, after)
    if after + 1 == string.length
      ''
    else
      divide_string(string[(after + 1)..(string.length - 1)])
    end
  end

  def trans_symbol_to_html(string, data_trans_symbol, inner_value)
    # data_trans_symbol, e.g. frc, int, sgm
    # inner_value is number of count in symbol
    category = if string.include?('{')
                 string = divide_string(string)
                 'pareent'
               else
                 'child'
               end
    make_html(string, data_trans_symbol, inner_value, category)
  end

  def make_html(string, data_trans_symbol, inner_value, category)
    html = ''
    (1..inner_value.to_i).each do |i|
      html += convert_to_html(string, data_trans_symbol, i, category)
      string = string[(string.index(']') + 1)..(string.length - 1)]
    end
    html += '</div>' if get_end_tag(data_trans_symbol)
    html
  end

  def convert_to_html(string, data_trans_symbol, count, category)
    html = ''
    before = string.index('(')
    after = string.index(']')
    html += select_optional_html(data_trans_symbol, count)
    child_class = "#{data_trans_symbol}_#{count.ordinalize}"
    add_string = string[(before + 1)..(after - 1)]
    html += add_division(add_string, "#{category} #{child_class}")
    html
  end

  def select_optional_html(data_trans_symbol, count)
    html = ''
    case data_trans_symbol
    when 'frc'
      html += '<hr>' if count == 2
    when 'igl'
      html += add_container if count == 2
    end
    html
  end

  def get_end_tag(data_trans_symbol)
    case data_trans_symbol
    when 'frc'
      false
    when 'igl'
      true
    else
      false
    end
  end
end
