require "uri"

class StaticFile
  attr_reader :type, :key

  def initialize(t, k)
    @type = t
    @key = k
  end

  def base_url
    @base_url ||= URI.parse(self.class.type_urls[type])
  end

  def url(options = {:protocol => "http"})
    if base_url
      p base_url.host
      base_url.scheme = options[:protocol]
      base_url.path = path
      base_url.to_s
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
