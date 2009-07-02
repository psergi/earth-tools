require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe EarthTools::Timezone do
  before do
    @timezone = EarthTools::Timezone.new
  end
  
  it "should have a version accessor" do
    @timezone.should respond_to(:version)
    @timezone.should respond_to(:version=)
  end
  it "should have a location accessor" do
    @timezone.should respond_to(:location)
    @timezone.should respond_to(:location=)
  end
  it "should have an offset accessor" do
    @timezone.should respond_to(:offset)
    @timezone.should respond_to(:offset=)
  end
  it "should have a suffix accessor" do
    @timezone.should respond_to(:suffix)
    @timezone.should respond_to(:suffix=)
  end
  it "should have a localtime accessor" do
    @timezone.should respond_to(:localtime)
    @timezone.should respond_to(:localtime=)
  end
  it "should have an isotime accessor" do
    @timezone.should respond_to(:isotime)
    @timezone.should respond_to(:isotime=)
  end
  it "should have a utctime accessor" do
    @timezone.should respond_to(:utctime)
    @timezone.should respond_to(:utctime=)
  end
  it "should have a dst accessor" do
    @timezone.should respond_to(:dst)
    @timezone.should respond_to(:dst=)
  end

  describe ".initialize" do
    before do
      @element = EarthTools::XML::Element.new(Nokogiri::XML('<?xml version="1.0" encoding="ISO-8859-1" ?> <timezone xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.earthtools.org/timezone.xsd"> <version>1.1</version> <location> <latitude>40.71417</latitude> <longitude>-74.00639</longitude> </location> <offset>-5</offset> <suffix>R</suffix> <localtime>4 Dec 2005 12:06:56</localtime> <isotime>2005-12-04 12:06:56 -0500</isotime> <utctime>2005-12-04 17:06:56</utctime> <dst>False</dst> </timezone>'))
      @timezone = EarthTools::Timezone.new(@element)
    end
    it "should set the version" do
      @timezone.version.should == '1.1'
    end
    it "should parse the location" do
      EarthTools::Location.should_receive(:new).with(@element['location']).and_return('location')
      timezone = EarthTools::Timezone.new(@element)
      timezone.location.should == 'location'
    end
    it "should set the offset" do
      @timezone.offset.should == '-5'
    end
    it "should set the suffix" do
      @timezone.suffix.should == 'R'
    end
    it "should set the localtime" do
      @timezone.localtime.should == '4 Dec 2005 12:06:56'
    end
    it "should set the isotime" do
      @timezone.isotime.should == '2005-12-04 12:06:56 -0500'
    end
    it "should set the utctime" do
      @timezone.utctime.should == '2005-12-04 17:06:56'
    end
    it "should set the dst" do
      @timezone.dst.should == 'False'
    end
    it "should not shit if nil is passed" do
      lambda { EarthTools::Timezone.new(nil) }.should_not raise_error
    end
  end
end
