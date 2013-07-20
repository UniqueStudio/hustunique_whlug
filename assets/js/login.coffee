$(document).ready ->
	class InputError
		constructor:(flag = false, message = "") ->
			@flag = flag
			@message = message

	class Checker
		constructor: ->
			@error = new InputError false

		student_no: (stu_no)->
			@error = new InputError true,"Student Number Input Error" unless /[2011137][0-9]{2}/.test stu_no
			@error

		student_pwd: (stu_pwd)->
			@error = new InputError true,"Password Input Error" unless /\d{9}/.test stu_pwd
			@error

	dispaly_error_info = (error)->
		$("#l_alert").show()
		$("#l_err").html(error)

	hidden_error_info = ->
		$("#l_alert").hide()

	$("#l_submit").click ->
		hidden_error_info()
		
		l_stu_no = $.trim $("#l_stu_no").val()
		l_stu_pwd = $.trim $("#l_stu_pwd").val()
		
		checker = new Checker()
		check_stu_no = checker.student_no l_stu_no

		if check_stu_no.flag is true
			dispaly_error_info check_stu_no.message
		else
			check_stu_pwd = checker.student_pwd l_stu_pwd
			if check_stu_pwd.flag is true
				dispaly_error_info check_stu_pwd.message
			else
				$.ajax {
					url: '/login'
					success: (result)->
						console.log eval('(' + result + ')')
						result = eval('(' + result + ')')
						window.location.href = '/home' if result.status is  true
						dispaly_error_info result.info

						return
					async: true
					type: 'POST'
					data: {
						'l_stu_no': l_stu_no
						'l_stu_pwd': md5(l_stu_pwd)
					}
				}
		return true
