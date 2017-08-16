module Front::Controllers::City
  class Show
    include Front::Action

    expose :city

    # @todo Move API uri to a configuration file
    def call(params)
      uri = uri_for(params[:city] || ENV['DEFAULT_CITY'])

      @city = JSON.parse(Net::HTTP.get_response(uri).body)
    end

    private

    def uri_for(city_name)
      URI("#{ENV['API_BASE_URI']}/api/city/#{city_name}")
    end
  end
end
