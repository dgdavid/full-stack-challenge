module Front::Controllers::City
  class Show
    include Front::Action

    expose :city

    # @todo Move default city value to a configuration file
    def initialize
      @default_city = 'Berlin'
    end

    # @todo Move API uri to a configuration file
    def call(params)
      uri = uri_for(params[:city] || @default_city)

      @city = JSON.parse(Net::HTTP.get_response(uri).body)
    end

    private

    def uri_for(city_name)
      URI("http://localhost:2300/api/city/#{city_name}")
    end
  end
end
