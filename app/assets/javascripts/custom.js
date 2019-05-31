

$(function(){
  $('#last').on('click', function(){
    var beforeFocusedElement = document.activeElement;

  });

  $('#add_clickme_btn_btn').on('click', function(){
    $('#btns_box').append(
      '<button class="clickme_btn">Click Me</button>'
    );
  });

  $(document).on("click", ".text_space", function () {
    var element = document.activeElement;
    $('#before_focused_id').val($(element).attr('id'));
    console.log(element);
    console.log($('#before_focused_id').val());
    var $focused = $(':focus');
    console.log($focused);
  });

});

