require File.dirname(__FILE__) + '/spec_helper.rb'

describe EarthTools do
  it "should have a version accessor" do
    EarthTools.should respond_to(:version)
    EarthTools.should respond_to(:version=)
  end
  it "should have a base uri accessor" do
    EarthTools.should respond_to(:base_uri)
    EarthTools.should respond_to(:base_uri=)
  end
  it "should set the base_uri to 'http://www.earthtools.org" do
    EarthTools.base_uri.should == 'http://www.earthtools.org'
  end
end
