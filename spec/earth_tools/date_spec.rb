require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe EarthTools::Date do
  before do
    @date = EarthTools::Date.new
  end
  it "should have day accessor" do
    @date.should respond_to(:day)
    @date.should respond_to(:day=)
  end
  it "should have a month accessor" do
    @date.should respond_to(:month)
    @date.should respond_to(:month=)
  end
  it "should have a timezone accessor" do
    @date.should respond_to(:timezone)
    @date.should respond_to(:timezone=)
  end
  it "should have a dst accessor" do
    @date.should respond_to(:dst)
    @date.should respond_to(:dst=)
  end

  describe ".initialize" do
    before do
      @element = EarthTools::XML::Element.new(Nokogiri::XML('<date><day>4</day><month>12</month><timezone>-5</timezone><dst>0</dst></date>'))
      @date = EarthTools::Date.new(@element)
    end
    it "should set the day" do
      @date.day.should == '4'
    end
    it "should set the month" do
      @date.month.should == '12'
    end
    it "should set the timezone" do
      @date.timezone.should == '-5'
    end
    it "should set the dst" do
      @date.dst.should == '0'
    end
    it "should not shit if nil is passed" do
      lambda { EarthTools::Date.new(nil) }.should_not raise_error
    end
  end
end
