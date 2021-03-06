// Generated by CoffeeScript 1.6.3
$(document).ready(function() {
  var dispaly_error_info, e_content_tag, elm_alert, elm_err, hidden_error_info;
  e_content_tag = CKEDITOR.replace("content", {
    height: 500,
    filebrowserBrowseUrl: '/wlg/setting/image_browser',
    filebrowserUploadUrl: '/wlg/setting/image_uploader'
  });
  elm_alert = $("div#l_alert");
  elm_err = $(elm_alert.children('p').get(0));
  dispaly_error_info = function(err) {
    elm_alert.show();
    return elm_err.html(err);
  };
  hidden_error_info = function() {
    elm_alert.hide();
    return elm_err.html('');
  };
  $("button#a_e_save").click(function() {
    var checker, e_content, e_title, e_writer;
    hidden_error_info();
    e_title = $.trim($("input#e_s_title").val());
    e_writer = $.trim($("input#e_s_writer").val());
    e_content = $.trim(e_content_tag.getData());
    checker = new Checker();
    if (checker.isTitle(e_title).isError()) {
      return dispaly_error_info(checker.error);
    }
    if (checker.isWriter(e_writer).isError()) {
      return dispaly_error_info(checker.error);
    }
    if (checker.isContent(e_content).isError()) {
      return dispaly_error_info(checker.error);
    }
    $.ajax({
      type: 'POST',
      url: '/wlg/setting/summary/add',
      data: {
        e_s_title: e_title,
        e_s_writer: e_writer,
        e_s_cont: e_content
      },
      success: function(result) {
        console.log(result);
        result = eval('(' + result + ')');
        dispaly_error_info(result.info);
        if (result.status === true) {
          window.location.href = '/wlg/setting/summary/page';
        }
      }
    });
  });
});
