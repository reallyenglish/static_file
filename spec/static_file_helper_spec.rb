require File.dirname(__FILE__) + "/../lib/static_file"

StaticFile.add_type_url(:cms3_resource, "assets.test.local")

module StaticFileHelper
  def request
    stub(:protocol => "https")
  end
end
describe StaticFileHelper do
  include StaticFileHelper
  it "calls correct url on file" do
    file = StaticFile.new(:cms3_resource, "bacon.jpg")

    static_file_url(file).should == "https://assets.test.local/bacon.jpg"
  end
end
