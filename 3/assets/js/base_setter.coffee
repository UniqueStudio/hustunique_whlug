class Checker
	constructor: ->
		@error = ''

	isError: ->
		!(@error.length is 0)

	isTitle: (title)->
		@error = "Title Not Empty" if title.length is 0
		this

	isWriter: (loc)->
		@error = "Writer Not Empty" if loc.length is 0
		this

	isContent: (con)->
		@error = "Content Not Empty" if con.length is 0
		this
