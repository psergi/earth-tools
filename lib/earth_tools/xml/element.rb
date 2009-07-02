module EarthTools
  module XML
    class Element
      attr_accessor :xml

      def initialize(xml)
        @xml = xml
      end

      def [](element)
        @xml.at(element).text rescue nil
      end
    end
  end
end

