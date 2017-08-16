require 'hanami/interactor'

# Fetch information for a country from its code through
# {https://restcountries.eu REST Countries} service
#
# Expose `name` and `currency` (the first occurence of currencies)
class CountryInformationFetcher
  include Hanami::Interactor

  expose :name, :currency

  # Creates a new instance and prepares the URI for request
  #
  # @param [Hash] opts the options to build a service call
  # @option opts [String] :code ISO 3166-1 2-letter 3-letter country code
  def initialize(opts = {})
    @uri = URI("#{ENV['RC_BASE_URI']}/alpha/#{opts[:code]}")
  end

  # Performs a request
  #
  # @todo Handle unexpected API responses
  def call
    response = Net::HTTP.get_response(@uri)
    data = JSON.parse(response.body)

    return if data.nil?

    @name = data['name']
    @currency = data['currencies'].first['code']
  end
end
