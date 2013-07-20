$(document).ready ->
	$.ajax {
		url: '/home/user'
		success: (result)->
			console.log result
			console.log $("#h_u_abbr").attr('title', result)
			$("#h_u_abbr").title result
			return
		async: true
		type: 'POST'
	}
	$('#content-timeline').timelinexml({ src: '/xml/content-timelinenew.xml'})
	return
