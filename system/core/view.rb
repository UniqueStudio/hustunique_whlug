#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

module Ash
  module ModuleApp

    class View
      attr_reader :api

      def initialize(obj_control)
        @api = obj_control
      end

      public
      def load_xhr_html(*args); self._load(self._path(*args)); end
      alias_method :load_static_file, :load_xhr_html

      def load_admin_file; self._load(self._path('admin_setter.rhtml', 'setter', true)); end

      def load_client_file; self._load(self._path('client_setter.rhtml', 'setter', true)); end

      protected
      def _path(f_name, m_name = '', flag = false)
        return "#{MAIN_PATH}plugin/#{m_name}/#{f_name}" if Object.const_defined? :ASH_DEBUG or flag == true
        "#{UtilsModules.module_path}#{f_name}"
      end

      def _load(path)
        raise ViewException, "#{path} do not exist or not readable" unless File.exist?(path) or File.readable?(path)
        File.open(path).read.to_s
      end
    end

    class ViewException < StandardError; end
  end
end
