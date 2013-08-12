#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

module Ash
	module Disposition

		# website uri
		COMMON_BASE_URI = 'http://localhost:8080/'

		# active
		COMMON_IS_ACTIVE = 2 ** 7
		COMMON_NOT_IS_ACTIVE = 2 ** 6

		# page
		COMMON_PAGE_SUCCESS = 100
		COMMON_PAGE_SUCCESS_INFO = 'Success'
		COMMON_PAGE_BIG_ERROR = 20
		COMMON_PAGE_BIG_ERROR_INFO = 'Unable Error'
		COMMON_PAGE_EQUAL = 50

	end
end
