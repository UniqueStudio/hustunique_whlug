class Checker
	constructor: ->
		@error = ''

	isError: ->
		!(@error.length is 0)

	isTitle: (title)->
		@error = "Title Not Empty" if title.length is 0
		this

	isTime: (time)->
		if time.length is 0
			@error = "Time Not Empty"
		else if !/^(201[0-9])-((0[1-9])|(1[0-2]))-((0[1-9])|([1-2][0-9])|(3[0-1]))$/.test time
			@error = "Event Time Format Error"
		this

	isLocation: (loc)->
		@error = "Location Not Empty" if loc.length is 0
		this

	isContent: (con)->
		@error = "Content Not Empty" if con.length is 0
		this
