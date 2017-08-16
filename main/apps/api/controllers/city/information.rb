module Api::Controllers::City
  class Information
    include Api::Action

    expose :city

    def initialize
      @city = {}
    end

    def call(params)
      return unless params[:city]

      city_name = params[:city]

      weather = WeatherInformationFetcher.new(city: city_name).call
      country = CountryInformationFetcher.new(city: city_name).call

      @city = {
        name: city_name,
        country: country.name,
        currency: country.currency,
        temperature: weather.temperature,
        condition_code: weather.condition_code
      }
    end
  end
end
