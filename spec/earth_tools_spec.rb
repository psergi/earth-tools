require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')

describe EarthTools do
  it "should have a base uri accessor" do
    EarthTools.should respond_to(:base_uri)
    EarthTools.should respond_to(:base_uri=)
  end
  it "should set the base_uri to 'http://www.earthtools.org" do
    EarthTools.base_uri.should == 'http://www.earthtools.org'
  end

  describe ".get" do
    before do
      Nokogiri.stub!(:XML)
      @response = '<?xml version="1.0" encoding="ISO-8859-1" ?><root></root>'
      EarthTools.stub!(:open).and_return(@response)
    end
    it "should make a request with the base uri" do
      EarthTools.should_receive(:open).with(Regexp.new(Regexp.escape(EarthTools.base_uri)))
      EarthTools.get('timezone')
    end
    it "should make a request to the service passed" do
      EarthTools.should_receive(:open).with(File.join(EarthTools.base_uri, "timezone"))
      EarthTools.get('timezone')
    end
    it "should make a versioned request if the version is passed" do
      EarthTools.should_receive(:open).with(File.join(EarthTools.base_uri, "timezone-1.1"))
      EarthTools.get('timezone', '1.1')
    end
    it "should seperate each of the params with slashes" do
      EarthTools.should_receive(:open).with(File.join(EarthTools.base_uri, "timezone", "one", "two", "three"))
      EarthTools.get('timezone', nil, 'one', 'two', 'three')
    end
    it "should build a Nokogiri::XML out of the response" do
      Nokogiri.should_receive(:XML).with(@response)
      EarthTools.get('timezone')
    end
    it "should return a EarthTools::XML::Element build from the Nokogiri document" do
      Nokogiri.stub!(:XML).and_return('xml')
      EarthTools::XML::Element.should_receive(:new).with('xml').and_return('earth tools element')
      EarthTools.get('timezone').should == 'earth tools element'
    end
  end
end
