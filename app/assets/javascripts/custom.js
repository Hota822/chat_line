//ToDo 文字の分割、a^２の自動変換, 他フォーマット用の変換（Σがでるように）
//文字列の入力（数学モードで）、変数の入力

//キャレット移動用関数（前後）
function goToAfterElement() {
  var selector = ".input_area, .symbol";
  var element = $(document.activeElement);
  var index = $(selector).index(element);
  var focusElement = null;
  for (var i = 1; i < 10; i++) {
    focusElement = $(selector).eq(index + i);
    if (focusElement.attr('contenteditable') == 'true') {
      setTimeout(function () {
        focusElement.focus();
      }, 1);
      break;
    }
  };
}
function goToBeforeElement() {
  var selector = ".input_area, .symbol";
  var element = $(document.activeElement);
  var index = $(selector).index(element);
  var focusElement = null;
  for (var i = 1; i < 10; i++) {
    focusElement = $(selector).eq(index - i);
    if (focusElement.attr('contenteditable') == 'true') {
      focusElement.focus();
      break;
    }
  };
}

//text_spaceのHTML>>文字列変換
function getString() {
  //var selector = ".input_area[data-highclass='true'], .parent['data-highclass']";
  var selector = ".input_area_first"
  var returnString = '';
  var target = $(selector).children()
  //改行の削除
  brElement = $(selector).find('br').each(function (index, brElm) {
    brElm.remove()
  });
  //文字列の取得
  if (target.length == 0) {
    //記号入力していないとき、そのまま文字列を返す
    return $(selector).text();
  } else {
    //記号があるときは変換して返す
    for (var i = 0; i < target.length; i++) {
      returnString += transSymbolToString(target.eq(i));
    };
    //returnString.replace(/\s|&nbsp;|\r?\n/g, '');
    return returnString;
  }
}
function transSymbolToString(element) {
  var dataTransSymbol = $(element).attr('data-transsymbol');
  if ($(element).attr('contenteditable') == 'true') {
    if (dataTransSymbol == 'dir') {
      console.log('dir');
      return $(element).text();
    } else {
      console.log('contedi=true, frc', element);
      return dataTransSymbol + '[' + $(element).text() + ']';
    }
  } else if ($(element).attr('data-transsymbol') === undefined) {
    return ''
  } else {
    var transedString = '';
    for (var i = 0; i < $(element).children().length; i++) {
      transedString += transSymbolToString($(element).children().eq(i));
    };
    console.log('trans', transedString);
    return dataTransSymbol + '[' + transedString + ']'
  }
}

$(function () {
  $(document).on("click", "#text_space", function () {
    //選択した要素のIDを記録
    //text_spaceの内、Bodyをクリックしたときは末尾にフォーカス
    
    var element = document.activeElement;
    console.log('click text_space event', element.id);
    var elementId = $(element).attr('id');
    if (elementId == null) {
      var index = $('.input_area').length - 1;
      var element = $('.input_area').eq(index);
      var elementId = element.attr('id');
      element.focus();
    }
    $('#before_focused_id').val(elementId);
  });

  //Placeholder の設定
  $(document).on('focusin', '.input_area', function (e) {
    //placeholder:通常エリア
    delete (this.dataset.placeholderactive);
    e.stopPropagation();
  });
  $(document).on('focusout', '.input_area', function (e) {
    e.stopPropagation();
    if (this.innerText.length === 0) {
      this.dataset.placeholderactive = 'true';
    }
  });
  $(document).on('focusin', '.symbol', function (e) {
    //placeholder:symbolエリア
    delete (this.dataset.placeholderactive);
    e.stopPropagation();
  });
  $(document).on('focusout', '.symbol', function (e) {
    if (this.innerText.length !== 0) return;
    this.dataset.placeholderactive = 'true';
    e.stopPropagation();
  });

  $(document).on("keydown", "#text_space", function (e) {
    //上下左右キーの動作変更
    switch (e.keyCode) {
      case 38: //  ↑キー
        goToBeforeElement();
        break;
      case 40: //  ↓キー
        goToAfterElement();
        break;
      case 37: //←キー
        var caretLocation = window.getSelection().anchorOffset;
        if (caretLocation == 0) {
          //何も起こさないのもあり？
          goToBeforeElement();
          console.log('left');
        }
        break;
      case 39: //→キー
        var caretEnd = $(document.activeElement).text().length;
        var caretLocation = window.getSelection().anchorOffset;
        if (caretLocation == caretEnd) {
          console.log('right');
          goToAfterElement();
        }
        break;
      case 13: //Enter
        $('button:contains("Send")').focus();
        break;
    }
  });


  $(document).on('click', 'button:contains("Send")', function () {

    var sendValue = getString();
    $('#talk_content').val(sendValue);
    console.log(sendValue);
    //$('#new_talk').submit();
  });
});
