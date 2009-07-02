module EarthTools
  class Sun
    class Twilight
      attr_accessor :civil, :nautical, :astronomical

      def initialize(attrs = {})
        attrs ||= {}
        @civil = attrs['civil']
        @nautical = attrs['nautical']
        @astronomical = attrs['astronomical']
      end
    end
  end
end
