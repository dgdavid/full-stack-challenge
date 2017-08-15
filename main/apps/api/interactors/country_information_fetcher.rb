require 'hanami/interactor'

# Fetch information for a country of given city name from
# {https://restcountries.eu REST Countries} service
#
# Only expose `name` and `currency` (the first occurence of currencies)
class CountryInformationFetcher
  include Hanami::Interactor

  expose :name, :currency

  # Creates a new instance and prepares the URI for request
  #
  # @todo Search by code or country name
  #   For now, it will to search by capital city, which is assumed is being
  #   received as a city name param. However, in the future it is wanted to
  #   receive the code or country name, since we could to retrieve it from
  #   WeatherInformationFetcher
  #
  # @param city_name [String]
  def initialize(city_name)
    @uri = URI("#{base_uri}/#{city_name}")
  end

  # Performs a request
  #
  # @todo Handle unexpected API responses
  def call
    response = Net::HTTP.get_response(@uri)
    data = JSON.parse(response.body)[0]

    return if data.nil?

    @name = data['name']
    @currency = data['currencies'].first['code']
  end

  private

  def base_uri
    'https://restcountries.eu/rest/v2/capital'
  end
end
