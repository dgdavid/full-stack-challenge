require 'net/http'
require_relative '../../../apps/api/interactors/weather_information_fetcher.rb'

RSpec.describe WeatherInformationFetcher do
  subject(:interactor) { described_class.new(params) }

  let(:params) { { city: 'Berlin' } }
  let(:uri_options) do
    { q: params[:city], units: 'metric', appid: ENV['OWM_APPID'] }
  end
  let(:uri) do
    uri = URI(ENV['OWM_BASE_URI'])
    uri.query = URI.encode_www_form(uri_options)
    uri
  end
  let(:fake_response) do
    response = {
      weather: [{ icon: '02d' }],
      main: { temp: 20 },
      sys: { country: 'DE' },
      cod: 200
    }

    OpenStruct.new(body: JSON.generate(response))
  end

  context 'when a city name is given' do
    it 'perform a request to OpenWeatherMap' do
      expect(Net::HTTP).to receive(:get_response).with(uri) { fake_response }

      interactor.call
    end

    it 'return when response code is not 200' do
      skip 'pending'
    end
  end

  context 'exposures' do
    before(:each) do
      allow(Net::HTTP).to receive(:get_response) { fake_response }
    end

    it 'expose a temperature' do
      expect(interactor.call.temperature).to eq(20)
    end

    it 'expose a condition_code' do
      expect(interactor.call.condition_code).to eq('02d')
    end

    it 'expose a country_code' do
      expect(interactor.call.country_code).to eq('DE')
    end
  end
end
