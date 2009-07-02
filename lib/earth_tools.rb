$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'open-uri'
require 'nokogiri'

require 'earth_tools/xml/element'
require 'earth_tools/date'
require 'earth_tools/location'
require 'earth_tools/height'
require 'earth_tools/sun/twilight'
require 'earth_tools/sun/evening'
require 'earth_tools/sun/morning'
require 'earth_tools/sun'
require 'earth_tools/timezone'

module EarthTools
  VERSION = '0.0.1'

  class << self
    attr_accessor :base_uri
  end

  self.base_uri = 'http://www.earthtools.org'

  def self.timezone(params)
    params = prepare_params(params)
    response = self.get('timezone', params['version'], params['latitude'], params['longitude'])
    EarthTools::Timezone.new(response)
  end

  def self.sun(params)
    params = { 'timezone' => '99', 'dst' => '0' }.merge(prepare_params(params))
    response = self.get('sun', params['version'], params['latitude'], params['longitude'], params['day'], params['month'], params['timezone'], params['dst']) 
    EarthTools::Sun.new(response)
  end

  def self.get(service, version = nil, *params)
    service = versioned_service(service, version)
    response = open(File.join(self.base_uri, service, *params))
    EarthTools::XML::Element.new(Nokogiri::XML(response))
  end

  private

  def self.versioned_service(service, version)
    return service if version.nil?
    "#{service}-#{version}"
  end

  def self.prepare_params(params)
    params.inject({}) do |options, (key, value)|
      options[key.to_s] = value.to_s
      options
    end
  end

end
