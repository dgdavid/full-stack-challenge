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

    it 'request city weather information' do
      allow(weather_information_fetcher).to receive(:call)
        .and_return(OpenStruct.new(temperature: 9, condition_code: '10d'))

      expect(WeatherInformationFetcher).to receive(:new)
        .with('Berlin')
        .and_return(weather_information_fetcher)

      action.call(params)
    end

    it 'request country information' do
      allow(country_information_fetcher).to receive(:call)
        .and_return(OpenStruct.new(name: 'Berlin', currency: 'EUR'))

      expect(CountryInformationFetcher).to receive(:new)
        .with('Berlin')
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
