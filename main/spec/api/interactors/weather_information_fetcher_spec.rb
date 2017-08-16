require 'net/http'
require_relative '../../../apps/api/interactors/weather_information_fetcher.rb'

RSpec.describe WeatherInformationFetcher do
  subject(:interactor) { described_class.new(params) }

  let(:fake_response) do
    OpenStruct.new(
      body: "{\"weather\":[{\"icon\":\"02d\"}],\"main\":{\"temp\":294.64},\"cod\":200}"
    )
  end
  let(:uri_options) do
    { q: params[:city], units: 'metric', appid: ENV['OWM_APPID'] }
  end
  let(:uri) do
    uri = URI(ENV['OWM_BASE_URI'])
    uri.query = URI.encode_www_form(uri_options)
    uri
  end

  context 'when a city name is given' do
    let(:params) { { city: 'Berlin' } }

    it 'perform a request to OpenWeatherMap' do
      expect(Net::HTTP).to receive(:get_response).with(uri) { fake_response }

      interactor.call
    end

    it 'return when response code is not 200' do
      skip 'pending'
    end
  end
end
