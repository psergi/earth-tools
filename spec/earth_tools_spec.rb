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

  describe ".timezone" do
    it "should do a get request to the timezone service" do
      EarthTools.should_receive(:get).with('timezone', anything, anything, anything)
      EarthTools.timezone('latitude' => '1.1', 'longitude' => '2.1')
    end
    it "should do a get request to the timezone service with the version when passed" do
      EarthTools.should_receive(:get).with('timezone', '1.0', anything, anything)
      EarthTools.timezone('latitude' => '1.1', 'longitude' => '2.1', 'version' => '1.0')
    end
    it "should pass the latitude and longitude to the get method in order" do
      EarthTools.should_receive(:get).with('timezone', '1.0', '1.1', '2.1')
      EarthTools.timezone('latitude' => '1.1', 'longitude' => '2.1', 'version' => '1.0')
    end
    it "should allow symbols as param keys" do
      EarthTools.should_receive(:get).with('timezone', '1.0', '1.1', '2.1')
      EarthTools.timezone(:latitude => '1.1', :longitude => '2.1', :version => '1.0')
    end
    it "should allow numbers as param values" do
      EarthTools.should_receive(:get).with('timezone', '1.0', '1.1', '2.1')
      EarthTools.timezone(:latitude => 1.1, :longitude => 2.1, :version => 1.0)
    end
    it "should return a timezone built from the get response" do
      EarthTools.should_receive(:get).and_return('response')
      EarthTools::Timezone.should_receive(:new).with('response').and_return('timezone')
      EarthTools.timezone(:latitude => 1.1, :longitude => 2.1, :version => 1.0).should == 'timezone'
    end
  end

  describe ".sun" do
    it "should do a get request to the sun service" do
      EarthTools.should_receive(:get).with('sun', anything, anything, anything, anything, anything, anything, anything)
      EarthTools.sun('latitude' => '1.1', 'longitude' => '2.1', 'day' => '1', 'month' => '12', 'timezone' => '-4', 'dst' => '0')
    end
    it "should do a get request to the sun service with the version when passed" do
      EarthTools.should_receive(:get).with('sun', '1.0', anything, anything, anything, anything, anything, anything)
      EarthTools.sun('latitude' => '1.1', 'longitude' => '2.1', 'day' => '1', 'month' => '12', 'timezone' => '-4', 'dst' => '0', 'version' => '1.0')
    end
    it "should pass the params to the get method in order" do
      EarthTools.should_receive(:get).with('sun', '1.0', '1.1', '2.1', '1', '12', '-4', '0')
      EarthTools.sun('latitude' => '1.1', 'longitude' => '2.1', 'day' => '1', 'month' => '12', 'timezone' => '-4', 'dst' => '0', 'version' => '1.0')
    end
    it "should allow symbols as param keys" do
      EarthTools.should_receive(:get).with('sun', '1.0', '1.1', '2.1', '1', '12', '-4', '0')
      EarthTools.sun(:latitude => '1.1', :longitude => '2.1', :day => '1', :month => '12', :timezone => '-4', :dst => '0', :version => '1.0')
    end
    it "should all numbers as param values" do
      EarthTools.should_receive(:get).with('sun', '1.0', '1.1', '2.1', '1', '12', '-4', '0')
      EarthTools.sun(:latitude => 1.1, :longitude => 2.1, :day => 1, :month => 12, :timezone => -4, :dst => 0, :version => 1.0)
    end
    it "should return a Sun built from the get response" do
      EarthTools.should_receive(:get).and_return('response')
      EarthTools::Sun.should_receive(:new).with('response').and_return('sun')
      EarthTools.sun(:latitude => 1.1, :longitude => 2.1, :day => 1, :month => 12, :timezone => -4, :dst => 0, :version => 1.0).should == 'sun'
    end
    it "should default the timezone as '99' if not passed" do
      EarthTools.should_receive(:get).with('sun', '1.0', '1.1', '2.1', '1', '12', '99', '0')
      EarthTools.sun(:latitude => 1.1, :longitude => 2.1, :day => 1, :month => 12, :dst => 0, :version => 1.0)
    end
    it "should default the dst to '0' if not passed" do
      EarthTools.should_receive(:get).with('sun', '1.0', '1.1', '2.1', '1', '12', '99', '0')
      EarthTools.sun(:latitude => 1.1, :longitude => 2.1, :day => 1, :month => 12, :version => 1.0)
    end
  end
end
