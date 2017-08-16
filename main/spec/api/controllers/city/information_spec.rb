require_relative '../../../../apps/api/controllers/city/information'

RSpec.describe Api::Controllers::City::Information do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  context 'when a city name is not given' do
    it 'return empty hash' do
      response = action.call(params)
      city = action.exposures[:city]

      %i[name country currency temperature condition_code].each do |prop|
        expect(city[prop]).to be_nil
      end
    end
  end

  context 'when a city name is given' do
    let(:params) { Hash[city: 'Berlin'] }
    let(:weather_information_fetcher) { double("WeatherInformatinoFetcher") }
    let(:country_information_fetcher) { double("CountryInformatinoFetcher") }
    let(:country_response) { OpenStruct.new(name: 'Berlin', currency: 'EUR') }
    let(:weather_response) do
      OpenStruct.new(condition_code: '10d', country_code: 'DE', temperature: 9)
    end

    it 'request city weather information' do
      allow(weather_information_fetcher).to receive(:call) { weather_response }

      expect(WeatherInformationFetcher).to receive(:new)
        .with({ city: 'Berlin' })
        .and_return(weather_information_fetcher)

      action.call(params)
    end

    it 'request country information' do
      allow(country_information_fetcher).to receive(:call) { country_response }

      expect(CountryInformationFetcher).to receive(:new)
        .with({ code: 'DE' })
        .and_return(country_information_fetcher)

      action.call(params)
    end

    it 'return a hash with city information' do
      response = action.call(params)
      city = action.exposures[:city]

      %i[name country currency temperature condition_code].each do |prop|
        expect(city[prop]).to_not be_nil
      end
    end
  end
end
