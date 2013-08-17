$(document).ready ->
	$("div#e_s_datetimepicker").datetimepicker({
		#maskInput: false
		pickTime: false
	})
	$("textarea#e_s_content").wysihtml5(
		'stylesheets': ['/bootstrap/css/wysiwyg-color.css']
	)

	elm_alert = $("div#l_alert")
	elm_err = $(elm_alert.children('p').get(0))
	dispaly_error_info = (err)->
		elm_alert.show()
		elm_err.html(err)

	hidden_error_info = ->
		elm_alert.hide()
		elm_err.html('')

	$("button.a_e_cancel").click ->
		window.location.href = "/wlg/setting/affair/page"

	$("button.a_e_save").click ->
		hidden_error_info()

		e_title = $.trim $("input#e_s_title").val()
		e_time = $.trim $("input#e_s_time").val()
		e_location = $.trim $("input#e_s_location").val()
		e_content = $.trim $("textarea#e_s_content").val()
		checker = new Checker()
		return dispaly_error_info(checker.error) if checker.isTitle(e_title).isError()
		return dispaly_error_info(checker.error) if checker.isTime(e_time).isError()
		return dispaly_error_info(checker.error) if checker.isLocation(e_location).isError()
		return dispaly_error_info(checker.error) if checker.isContent(e_content).isError()

		$.ajax({
			type: 'POST'
			url: '/wlg/setting/affair/add'
			data:{
				e_s_title: e_title
				e_s_time: e_time
				e_s_loc: e_location
				e_s_cont: e_content
			}
			success: (result)->
				console.log result
				result = eval('(' + result + ')')
				dispaly_error_info(result.info)
				window.location.href = '/wlg/setting/affair/page' if result.status is true
				return
		})

		return
	return
