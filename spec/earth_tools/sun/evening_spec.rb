require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper.rb')

describe EarthTools::Sun::Evening do
  before do
    @evening = EarthTools::Sun::Evening.new
  end

  it "should have a sunset accessor" do
    @evening.should respond_to(:sunset)
    @evening.should respond_to(:sunset=)
  end
  it "should have a twilight accessor" do
    @evening.should respond_to(:twilight)
    @evening.should respond_to(:twilight=)
  end

  describe ".initialize" do
    before do
      @element = EarthTools::XML::Element.new(Nokogiri::XML('<evening> <sunset>16:27:01</sunset> <twilight> <civil>16:57:44</civil> <nautical>17:31:59</nautical> <astronomical>18:05:10</astronomical> </twilight> </evening>'))
      @evening = EarthTools::Sun::Evening.new(@element)
    end
    it "should set the sunset" do
      @evening.sunset.should == '16:27:01'
    end
    it "should parse the twilight" do
      EarthTools::Sun::Twilight.should_receive(:new).with(@element['twilight']).and_return('twilight')
      evening = EarthTools::Sun::Evening.new(@element)
      evening.twilight.should == 'twilight'
    end
    it "should not shit if nil is passed" do
      lambda { EarthTools::Sun::Evening.new(nil) }.should_not raise_error
    end
  end
end
