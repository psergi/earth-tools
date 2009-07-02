module EarthTools
  module XML
    class Element
      attr_accessor :xml

      def initialize(xml)
        @xml = xml
      end

      def [](element)
        element = @xml.at(element)
        return unless element
        element.children.any? { |c| c.element? } ? EarthTools::XML::Element.new(element) : element.text
      end
    end
  end
end

