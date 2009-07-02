module EarthTools
  class Height
    attr_accessor :version, :location, :meters, :feet

    def initialize(attrs = {})
      attrs ||= {}
      @version = attrs['version']
      @location = EarthTools::Location.new(attrs['location'])
      @meters = attrs['meters']
      @feet = attrs['feet']
    end
  end
end
