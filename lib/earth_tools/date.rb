module EarthTools
  class Date
    attr_accessor :day, :month, :timezone, :dst
    
    def initialize(attrs = {})
      attrs ||= {}
      @day = attrs['day']
      @month = attrs['month']
      @timezone = attrs['timezone']
      @dst = attrs['dst']
    end
  end
end
