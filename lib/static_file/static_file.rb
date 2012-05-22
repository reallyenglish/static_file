require "uri"

class StaticFile
  attr_reader :type, :key

  def initialize(t, k)
    @type = t
    @key = k
  end

  def base_url
    self.class.type_urls[type]
  end

  def url(options = {:protocol => "http"})
    if base_url
      options.merge!(:host => base_url, :path => path, :scheme => options[:protocol])
      url = URI::HTTP.build(options).to_s
    else
      raise "unknown type: #{@type}"
    end
  end

  def path
    if !key.match(/^\//)
      "/#{key}" 
    else
      key
    end
  end

  class << self
    attr_accessor :type_urls

    def add_type_url(type, url)
      self.type_urls ||= {}
      self.type_urls[type] = url 
    end

    def create(str)
      t, k = str.scan(/^([a-z].*?):(.*)$/).first
      raise "key format is wrong: #{str}" unless t and k
      self.new(t.to_sym, k)
    end
  end
end
