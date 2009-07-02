require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper.rb')

describe EarthTools::Sun::Morning do
  before do
    @morning = EarthTools::Sun::Morning.new
  end

  it "should have a sunrise accessor" do
    @morning.should respond_to(:sunrise)
    @morning.should respond_to(:sunrise=)
  end
  it "should have a twilight accessor" do
    @morning.should respond_to(:twilight)
    @morning.should respond_to(:twilight=)
  end

  describe ".initialize" do
    before do
      @element = EarthTools::XML::Element.new(Nokogiri::XML('<morning> <sunrise>07:05:34</sunrise> <twilight> <civil>06:34:51</civil> <nautical>06:00:36</nautical> <astronomical>05:27:25</astronomical> </twilight> </morning>'))
      @morning = EarthTools::Sun::Morning.new(@element)
    end
    it "should set the sunrise" do
      @morning.sunrise.should == '07:05:34'
    end
    it "should parse the twilight" do
      EarthTools::Sun::Twilight.should_receive(:new).with(@element['twilight']).and_return('twilight')
      morning = EarthTools::Sun::Morning.new(@element)
      morning.twilight.should == 'twilight'
    end
    it "should not shit if nil is passed" do
      lambda { EarthTools::Sun::Morning.new(nil) }.should_not raise_error
    end
  end
end

