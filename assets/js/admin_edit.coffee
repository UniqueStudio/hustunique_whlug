$(document).ready ->
	$(".form_datetime").datetimepicker {
		format: "dd mm yyyy"
		autoclose: true
		todayBtn: true
		todayHightlight: true
		startDate: "2011-09-08"
		minuteStep: 10
		minView: 2
	}

	class InputError
		constructor:(flag = false, message = "") ->
			@flag = flag
			@message = message

	class Checker
		constructor: ->
			@error = new InputError false

		event_date: (date) ->
			@error = new InputError true,"Event Date Input Error" unless /^[0-9]{1,2} [0-9]{2} [0-9]{4}$/.test date
			@error

		event_details: (title, content) ->
			@error = new InputError true,"Event Title And Content Not Empty" if title.length is 0 or content.length is 0
			@error

	dispaly_error_info = (error)->
		$("#l_alert").show()
		$("#l_err").html(error)

	hidden_error_info = ->
		$("#l_alert").hide()

	$("#a_submit").click ->
		hidden_error_info()

		a_event_date = $.trim $("#a_event_date").val()
		a_event_title = $.trim $("#a_event_title").val()
		a_event_content = $.trim $("#a_event_content").val()
		a_id = $.trim $("#a_hidden").val()

		console.log $("#a_event_date").val()
		console.log $("#a_event_title").val()
		console.log $("#a_event_content").val()
		console.log a_id

		checker = new Checker()
		check_date = checker.event_date a_event_date

		if check_date.flag is true
			dispaly_error_info check_date.message
		else
			check_detail = checker.event_details a_event_title, a_event_content
			if check_detail.flag is true
				dispaly_error_info check_detail.message
			else
				$.ajax {
					url: '/admin/edit'
					success: (result)->
						console.log eval('(' + result + ')')
						result = eval('(' + result + ')')
						dispaly_error_info result.info
						window.location.href = '/admin/edit'

						return
					async: true
					type: 'POST'
					data: {
						'e_date': a_event_date
						'e_title': a_event_title
						'e_content': a_event_content
						'e_eid': a_id
					}
				}
		return true

	return
