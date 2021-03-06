require 'hanami/interactor'

# Fetch information for a given city name from
# {https://openweathermap.org OpenWeatherMap} service
#
# Expose `condition_code` (aka weather icon), `country_code` and `temperature`
class WeatherInformationFetcher
  include Hanami::Interactor

  expose :condition_code, :country_code, :temperature

  # Creates a new instance and prepares the URI for request
  #
  # @see http://openweathermap.org/current OpenWeatherMap API doc
  #
  # @param [Hash] opts the options to build a service call
  # @option opts [String] :city Name of city to search
  # @option opts [String] :unit Desired unit for temperature
  # @option opts [String] :appid OpenWeatherMap API key
  def initialize(opts = {})
    query = {
      q: opts[:city],
      units: opts[:unit] || ENV['OWM_DEFAULT_UNIT'],
      appid: opts[:appid] || ENV['OWM_APPID']
    }

    @uri = URI(ENV['OWM_BASE_URI'])
    @uri.query = URI.encode_www_form(query.compact)
  end

  # Performs a request
  def call
    response = Net::HTTP.get_response(@uri)
    data = JSON.parse(response.body)

    return unless data['cod'].eql?(200) # TODO: handle API errors

    @condition_code = data['weather'][0]['icon']
    @country_code = data['sys']['country']
    @temperature = data['main']['temp']
  end
end
