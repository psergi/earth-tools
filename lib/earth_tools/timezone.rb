module EarthTools
  class Timezone
    attr_accessor :version, :location, :offset, :suffix, :localtime, :isotime, :utctime, :dst

    def initialize(attrs = {})
      @version = attrs['version']
      @location = EarthTools::Location.new(attrs['location'])
      @offset = attrs['offset']
      @suffix = attrs['suffix']
      @localtime = attrs['localtime']
      @isotime = attrs['isotime']
      @utctime = attrs['utctime']
      @dst = attrs['dst']
    end
  end
end

