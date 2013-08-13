#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

module Ash
	module ModuleTool

		PagesetterList = Struct.new(:user, :message)
		PagesetterUserList = Struct.new(:name, :email)
		PagesetterMsgList = Struct.new(:being_used, :used)

	end
end
