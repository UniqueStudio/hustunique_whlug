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

		COMMON_PAGE_EDIT_EVENT = 2 * 1
		COMMON_PAGE_LIST_EVENT = 2 * 2

		# setter page
		COMMON_SETTER_IS_BEING_USED = 2 ** 10
		COMMON_SETTER_NOT_IS_BEING_USED = 2 ** 9
		COMMON_SETTER_PAGE_MAX_NUM = 10

		# event page
		COMMON_EVENT_IS_ACTIVE = 2 ** 12
		COMMON_EVENT_NOT_IS_ACTIVE = 2 ** 11
		COMMON_EVENT_PAGE_MAX_NUM = 10

	end
end
