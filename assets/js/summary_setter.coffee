$(document).ready ->
  e_content_tag = CKEDITOR.replace("content",{
    height: 500,
    filebrowserBrowseUrl: '/wlg/setting/image_browser'
    filebrowserUploadUrl: '/wlg/setting/image_uploader'
  })
  elm_alert = $("div#l_alert")
  elm_err = $(elm_alert.children('p').get(0))
  dispaly_error_info = (err)->
    elm_alert.show()
    elm_err.html(err)

  hidden_error_info = ->
    elm_alert.hide()
    elm_err.html('')

  $("button#a_e_save").click ->
    hidden_error_info()

    e_title = $.trim $("input#e_s_title").val()
    e_writer = $.trim $("input#e_s_writer").val()
    e_content = $.trim e_content_tag.getData()
    checker = new Checker()
    return dispaly_error_info(checker.error) if checker.isTitle(e_title).isError()
    return dispaly_error_info(checker.error) if checker.isWriter(e_writer).isError()
    return dispaly_error_info(checker.error) if checker.isContent(e_content).isError()

    $.ajax({
      type: 'POST'
      url: '/wlg/setting/summary/add'
      data:{
        e_s_title: e_title
        e_s_writer: e_writer
        e_s_cont: e_content
      }
      success: (result)->
        console.log result
        result = eval('(' + result + ')')
        dispaly_error_info(result.info)
        window.location.href = '/wlg/setting/summary/page' if result.status is true
        return
    })

    return
  return
