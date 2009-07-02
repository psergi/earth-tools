require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper.rb')

describe EarthTools::XML::Element do
  before do
    @xml = Nokogiri::XML('<item><time>10:20:12</time><nested><time>10:00:00</time></nested></item>')
    @element = EarthTools::XML::Element.new(@xml)
  end

  it "should have an xml accessor" do
    @element.should respond_to(:xml)
    @element.should respond_to(:xml=)
  end

  describe "initialize" do
    it "should take be initialized with an xml object" do
      element = EarthTools::XML::Element.new(@xml)
      element.xml.should == @xml
    end
  end

  describe "['element']" do
    before do
      @element = EarthTools::XML::Element.new(@xml)
    end
    it "should to parse out the text of the element passed" do
      @element['time'].should == '10:20:12'
    end
    it "should to return nil if the element is not found" do
      @element['text'].should be_nil
    end
    it "should return an EarthTools::XML::Element of the requested element has children" do
      @element['nested'].should be_kind_of(EarthTools::XML::Element)
    end
  end
end
