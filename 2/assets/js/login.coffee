$(document).ready ->
	class Checker
		constructor: ->
			@error = ''

		isError: ->
			!@error.length is 0

		isEmail: (eml)->
			@error = "Student Number Input Error" unless /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test eml
			this

		isPassword: (pwd)->
			@error = "Password Not Empty" if pwd.length is 0
			this

	elm_alert = $("div#l_alert")
	elm_err = $(elm_alert.children('p').get(0))
	dispaly_error_info = (err)->
		elm_alert.show()
		elm_err.html(err)

	hidden_error_info = ->
		elm_alert.hide()
		elm_err.html('')

	$("button#l_submit").click ->
		hidden_error_info()
		u_email = $.trim $("#l_u_email").val()
		u_pwd = $.trim $("#l_u_pwd").val()
		_checker = new Checker()

		if _checker.isEmail(u_email).isError() is true
			dispaly_error_info _checker.error
		else
			if _checker.isPassword(u_pwd).isError() is true
				dispaly_error_info _checker.error
			else
				$.ajax {
					url: '/wlg-login'
					success: (result)->
						console.log eval('(' + result + ')')
						result = eval('(' + result + ')')
						window.location.href = '/wlg/setting' if result.status is  true
						dispaly_error_info result.info

						return
					async: true
					type: 'POST'
					data: {
						'l_u_email': u_email
						'l_u_pwd': md5(u_pwd)
					}
				}
		return true
