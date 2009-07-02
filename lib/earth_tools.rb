$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'nokogiri'

require 'earth_tools/xml/element'
require 'earth_tools/date'
require 'earth_tools/location'
require 'earth_tools/height'
require 'earth_tools/sun/twilight'
require 'earth_tools/sun/evening'
require 'earth_tools/sun/morning'

module EarthTools
  VERSION = '0.0.1'

  class << self
    attr_accessor :version, :base_uri
  end

  self.base_uri = 'http://www.earthtools.org'

end
