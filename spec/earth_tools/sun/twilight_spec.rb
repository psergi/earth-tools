require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper.rb')

describe EarthTools::Sun::Twilight do
  before do
    @twilight = EarthTools::Sun::Twilight.new
  end

  it "should have a civil accessor" do
    @twilight.should respond_to(:civil)
    @twilight.should respond_to(:civil=)
  end
  it "should have a nautical accessor" do
    @twilight.should respond_to(:nautical)
    @twilight.should respond_to(:nautical=)
  end
  it "should have a astronomical accessor" do
    @twilight.should respond_to(:astronomical)
    @twilight.should respond_to(:astronomical=)
  end

  describe ".initialize" do
    before do
      @element = EarthTools::XML::Element.new(Nokogiri::XML('<twilight> <civil>16:57:44</civil> <nautical>17:31:59</nautical> <astronomical>18:05:10</astronomical> </twilight>'))
      @twilight = EarthTools::Sun::Twilight.new(@element)
    end
    it "should set the civil" do
      @twilight.civil.should == '16:57:44'
    end
    it "should set the nautical" do
      @twilight.nautical.should == '17:31:59'
    end
    it "should set the astronomical" do
      @twilight.astronomical.should == '18:05:10'
    end
    it "should not shit if nil is passed" do
      lambda { EarthTools::Sun::Twilight.new(nil) }.should_not raise_error
    end
  end
end
