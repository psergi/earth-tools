require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe EarthTools::Height do
  before do
    @height = EarthTools::Height.new
  end
  it "should have a version accessor" do
    @height.should respond_to(:version)
    @height.should respond_to(:version=)
  end
  it "should have a location accessor" do
    @height.should respond_to(:location)
    @height.should respond_to(:location=)
  end
  it "should have a meters accessor" do
    @height.should respond_to(:meters)
    @height.should respond_to(:meters=)
  end
  it "should have a feet accessor" do
    @height.should respond_to(:feet)
    @height.should respond_to(:feet=)
  end

  describe ".initialize" do
    before do
      @element = EarthTools::XML::Element.new(Nokogiri::XML('<height xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.earthtools.org/height.xsd"> <version>1.0</version> <location> <latitude>52.4822</latitude> <longitude>-1.8946</longitude> </location> <meters>141</meters> <feet>462.6</feet> </height>'))
      @height = EarthTools::Height.new(@element)
    end
    it "should set the version" do
      @height.version.should == '1.0'
    end
    it "should parse the location" do
      EarthTools::Location.should_receive(:new).with(@element['location']).and_return('location')
      height = EarthTools::Height.new(@element)
      height.location.should == 'location'
    end
    it "should set the meters" do
      @height.meters.should == '141'
    end
    it "should set the feet" do
      @height.feet.should == '462.6'
    end
    it "should not shit if nil is passed" do
      lambda { EarthTools::Height.new(nil) }.should_not raise_error
    end
  end
end

