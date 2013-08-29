#coding: UTF-8

exit unless Object.const_defined? :ACCESS_ERROR

module Ash
  module UtilsCommon

    def self.load_routing_conf_files
      routing_files = Set.new(Dir.glob("#{Disposition::MAIN_DIR_ADAPTER}*.rb"))
      routing_files.each {|file| require file}
    end
  end

  module UtilsModules

    def self.load_files(module_name, submodule_name = '')
      module_name = module_name.downcase
      unless submodule_name.empty?
        submodule_name = submodule_name.downcase
        @module_name = submodule_name.capitalize + module_name.capitalize
        @module_path = Disposition::MAIN_DIR_PLUGIN + module_name + ASH_SEP + submodule_name + ASH_SEP
        @module_view_file, @module_control_file = "#{@module_path + submodule_name}_#{module_name}_view.rb", "#{@module_path + submodule_name}_#{module_name}_control.rb"
      else
        @module_name = module_name.capitalize
        @module_path = Disposition::MAIN_DIR_PLUGIN + module_name + ASH_SEP
        @module_view_file, @module_control_file = "#{@module_path + module_name}_view.rb", "#{@module_path + module_name}_control.rb"
      end
      raise "#{@module_path} modules do not exist" unless Dir.exists? @module_path
      raise "#{@module_view_file} file do not exist" unless File.exist? @module_view_file
      #raise "#{@module_control_file} file do not exist" unless File.exist? @module_control_file
      require @module_view_file
      #require @module_control_file
    end

    def self.module_name
      @module_name
    end

    def self.module_path
      @module_path
    end

    def self.display_outline(request, function = 'default', params = [])
      puts "Request\t\t=> #{request.request_method} #{request.url} #{request.ip}\n"
      puts "File\t\t=> #{@module_view_file}"
      puts "Function\t=> Ash::ModuleApp::#{@module_name.capitalize}.new.#{function}\n"
      puts "Params\t\t=> #{params}"
      puts "Time\t\t=> #{Time.now.gmtime}"
    end
  end
end
