module EarthTools
  class Sun
    class Evening
      attr_accessor :sunset, :twilight

      def initialize(attrs = {})
        attrs ||= {}
        @sunset = attrs['sunset']
        @twilight = EarthTools::Sun::Twilight.new(attrs['twilight'])
      end
    end
  end
end
