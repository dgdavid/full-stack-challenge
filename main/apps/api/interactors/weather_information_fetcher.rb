require 'hanami/interactor'

# Fetch information for a given city name from
# {https://openweathermap.org OpenWeatherMap} service
#
# Only expose `temperature` and `condition_code`
class WeatherInformationFetcher
  include Hanami::Interactor

  expose :condition_code, :temperature

  # Creates a new instance and prepares the URI for request
  #
  # @todo Allow to receive more params
  #   Units and APPID, for example; maybe in a single Hash
  #
  # @param city_name [String]
  def initialize(city_name)
    @uri = URI(base_uri)
    @uri.query = URI.encode_www_form({
      q: city_name,
      units: :metric,
      APPID: 'c22c1e116a64e88c7bf837212af83243' # FIXME: move to a configuration file
    })
  end

  # Performs a request
  def call
    response = Net::HTTP.get_response(@uri)
    data = JSON.parse(response.body)

    return if data['cod'] # TODO: handle API errors

    @temperature = data['main']['temp']
    @condition_code = data['weather'][0]['icon']
  end

  private

  def base_uri
    'https://api.openweathermap.org/data/2.5'
  end
end
