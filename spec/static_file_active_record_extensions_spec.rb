require 'sqlite3'
require "active_record"
require File.join(File.dirname(__FILE__), "..", "lib", "static_file")

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

ActiveRecord::Migration.create_table(:people) {|t| t.string :avatar }

class Person < ActiveRecord::Base
  static_file :avatar
end

StaticFile.add_type_url(:cms3_resource, "test.local")

describe StaticFileActiveRecordExtensions do  
  describe "static file" do
    before(:each) do
      @static_file = StaticFile.create("cms3_resource:abcdef")
      @instance = Person.create
    end

    it "should return Rems::StaticFile instance when it's set" do
      @instance.avatar = @static_file
      @instance.avatar.url.should == @static_file.url
    end

    it "should be set to nil" do
      @instance.avatar = @static_file
      @instance.avatar.url.should == @static_file.url
      @instance.avatar = nil
      @instance.avatar.should be_nil
    end

    it "should create StaticFile Object" do
      @instance[:avatar] = "cms3_resource:abcdef"
      @instance.avatar.should be_instance_of(StaticFile)
      @instance.avatar.type.should == :cms3_resource
      @instance.avatar.key.should == "abcdef"
    end
  end
end
