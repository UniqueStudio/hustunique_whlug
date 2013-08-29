#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

require "#{Ash::Disposition::SYS_DIR_CORE}view.rb"

module Ash
	module ModuleApp

		class ContactView < View

			def initialize; super(nil); end

			def default; self.load_static_file('contactus.html'); end

		end
	end
end
