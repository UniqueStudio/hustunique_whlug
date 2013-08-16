#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

module Ash
	module ModuleTool

		#PagesetterList = Struct.new(:user, :message) do
			#def get_binding
				#binding()
			#end
		#end
		#PagesetterUserList = Struct.new(:name, :email)
		#PagesetterMsgList = Struct.new(:being_used, :used)

		PagesetterList = Struct.new(:content, :active) do
			def get_binding
				binding()
			end
		end

	end
end
