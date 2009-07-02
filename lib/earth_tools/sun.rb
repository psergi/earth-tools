module EarthTools
  class Sun
    attr_accessor :version, :location, :date, :morning, :evening

    def initialize(attrs = {})
      attrs ||= {}
      @version = attrs['version']
      @location = EarthTools::Location.new(attrs['location'])
      @date = EarthTools::Date.new(attrs['date'])
      @morning = EarthTools::Sun::Morning.new(attrs['morning'])
      @evening = EarthTools::Sun::Evening.new(attrs['evening'])
    end
  end
end
