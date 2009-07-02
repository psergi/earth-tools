module EarthTools
  class Sun
    class Morning
      attr_accessor :sunrise, :twilight

      def initialize(attrs = {})
        attrs ||= {}
        @sunrise = attrs['sunrise']
        @twilight = EarthTools::Sun::Twilight.new(attrs['twilight'])
      end
    end
  end
end

