$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module EarthTools
  VERSION = '0.0.1'

  class << self
    attr_accessor :version, :base_uri
  end

  self.base_uri = 'http://www.earthtools.org'

end
