require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe EarthTools::Sun do
  before do
    @sun = EarthTools::Sun.new
  end

  it "should have a version accessor" do
    @sun.should respond_to(:version)
    @sun.should respond_to(:version=)
  end
  it "should have a location accessor" do
    @sun.should respond_to(:location)
    @sun.should respond_to(:location=)
  end
  it "should have a date accessor" do
    @sun.should respond_to(:date)
    @sun.should respond_to(:date=)
  end
  it "should have a morning accessor" do
    @sun.should respond_to(:morning)
    @sun.should respond_to(:morning=)
  end
  it "should have an evening accessor" do
    @sun.should respond_to(:evening)
    @sun.should respond_to(:evening=)
  end

  describe ".initialize" do
    before do
      @element = EarthTools::XML::Element.new(Nokogiri::XML('<sun xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.earthtools.org/sun.xsd"> <version>1.0</version> <location> <latitude>40.71417</latitude> <longitude>-74.00639</longitude> </location> <date> <day>4</day> <month>12</month> <timezone>-5</timezone> <dst>0</dst> </date> <morning> <sunrise>07:05:34</sunrise> <twilight> <civil>06:34:51</civil> <nautical>06:00:36</nautical> <astronomical>05:27:25</astronomical> </twilight> </morning> <evening> <sunset>16:27:01</sunset> <twilight> <civil>16:57:44</civil> <nautical>17:31:59</nautical> <astronomical>18:05:10</astronomical> </twilight> </evening> </sun>'))
      @sun = EarthTools::Sun.new(@element)
    end
    it "should set the version" do
      @sun.version.should == '1.0'
    end
    describe "complex attributes" do
      before do
        @element.stub!(:[])
      end
      it "should parse the location" do
        @element.should_receive(:[]).with('location').and_return('location element')
        EarthTools::Location.should_receive(:new).with('location element').and_return('location')
        sun = EarthTools::Sun.new(@element)
        sun.location.should == 'location'
      end
      it "should parse the date" do
        @element.should_receive(:[]).with('date').and_return('date element')
        EarthTools::Date.should_receive(:new).with('date element').and_return('date')
        sun = EarthTools::Sun.new(@element)
        sun.date.should == 'date'
      end
      it "should parse the morning" do
        @element.should_receive(:[]).with('morning').and_return('morning element')
        EarthTools::Sun::Morning.should_receive(:new).with('morning element').and_return('morning')
        sun = EarthTools::Sun.new(@element)
        sun.morning.should == 'morning'
      end
      it "should parse the evening" do
        @element.should_receive(:[]).with('evening').and_return('evening element')
        EarthTools::Sun::Evening.should_receive(:new).with('evening element').and_return('evening')
        sun = EarthTools::Sun.new(@element)
        sun.evening.should == 'evening'
      end
    end
    it "should not shit if nil is passed" do
      lambda { EarthTools::Sun.new(nil) }.should_not raise_error
    end
  end
end

