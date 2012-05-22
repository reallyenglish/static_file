require File.dirname(__FILE__) + "/../lib/static_file"

StaticFile.type_urls = {:cms3_resource => "assets.test.local"}

describe StaticFileHelper do
  it "should initialize with type and key for cms3 resource" do
    o = StaticFile.new(:cms3_resource, "abcdefg")
    o.url.should == "http://assets.test.local/abcdefg"
    o.key.should == "abcdefg"
  end

  it "should initialize with type+key for cms3 resource" do
    o = StaticFile.create('cms3_resource:abcdefg')
    o.url.should == "http://assets.test.local/abcdefg"
    o.key.should == "abcdefg"
  end
end
