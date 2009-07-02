module EarthTools
  class Location
    attr_accessor :latitude, :longitude

    def initialize(attrs = {})
      attrs ||= {}
      @latitude = attrs['latitude']
      @longitude = attrs['longitude']
    end
  end
end

