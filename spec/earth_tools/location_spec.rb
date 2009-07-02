require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe EarthTools::Location do
  before do
    @location = EarthTools::Location.new
  end
  it "should have latitude accessor" do
    @location.should respond_to(:latitude)
    @location.should respond_to(:latitude=)
  end
  it "should have longitude accessor" do
    @location.should respond_to(:longitude)
    @location.should respond_to(:longitude=)
  end

  describe ".initialize" do
    before do
      @element = EarthTools::XML::Element.new(Nokogiri::XML('<location><latitude>40.71417</latitude><longitude>-74.00639</longitude></location>'))
      @location = EarthTools::Location.new(@element)
    end
    it "should set the latitude" do
      @location.latitude.should == '40.71417'
    end
    it "should set the longitude" do
      @location.longitude.should == '-74.00639'
    end
    it "should not shit if nil is passed" do
      lambda { EarthTools::Location.new(nil) }.should_not raise_error
    end
  end
end
