lib_base = File.join(File.dirname(__FILE__), "static_file")

require File.join(lib_base, "static_file")
require File.join(lib_base, "static_file_helper")

if defined?(ActiveRecord)
  require File.join(lib_base, "static_file_active_record_extensions")
end
