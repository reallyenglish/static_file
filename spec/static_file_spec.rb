require File.dirname(__FILE__) + "/../lib/static_file/static_file.rb"

describe StaticFile do
  context "with type specific urls" do
    before do
      StaticFile.add_type_url(:cms3_resource, "cms3.local")
    end
    it "chooses full url based on configured types" do
      StaticFile.type_urls[:cms3_resource].should == "cms3.local"
    end

    it "generates a url from type & key" do
      file = StaticFile.new(:cms3_resource, "bacon.jpg")

      file.url.should == "http://cms3.local/bacon.jpg"
    end

    it "raises an error if type is not found" do
      -> { StaticFile.new(:nothing, "nothing.jpg").new.url }.should raise_error
    end

    it "raises an error if key is invalid" do
      -> { StaticFile.new(:cms3_resource, "A-+ Som\'not").new.url }.should raise_error
    end
  end
end
