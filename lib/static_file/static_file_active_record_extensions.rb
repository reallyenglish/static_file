module StaticFileActiveRecordExtensions
  # set up a field for static file
  def static_file(attribute)
    attribute = attribute.to_sym
    attribute_s = attribute.to_s

    define_method(attribute_s) do
      if self[attribute]
        StaticFile.create(self[attribute])
      else
        nil
      end
    end

    define_method("#{attribute_s}=") do |static_file|
      if static_file.nil?
        self[attribute] = nil
      else
        raise "expected StaticFile but #{static_file}" unless static_file.is_a?(StaticFile)
        self[attribute] = static_file.type.to_s + ":" + static_file.key
      end
    end
  end
end 

ActiveRecord::Base.send(:extend, StaticFileActiveRecordExtensions)
