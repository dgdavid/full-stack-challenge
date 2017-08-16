require_relative '../../../../apps/front/controllers/city/show'

RSpec.describe Front::Controllers::City::Show do
  let(:action) { described_class.new }

  context 'When a :city param is not given' do
    let(:params) { Hash[] }

    it 'request city information for "Berlin"' do
      expect(Net::HTTP).to receive(:get_response)
        .with(URI('http://localhost:2300/api/city/Berlin'))
        .and_return(OpenStruct.new(body: '{"name": "Berlin"}'))

      action.call(params)
    end
  end

  context 'When a :city param is given' do
    let(:params) { Hash[city: 'Madrid'] }

    it 'request city information for it' do
      expect(Net::HTTP).to receive(:get_response)
        .with(URI('http://localhost:2300/api/city/Madrid'))
        .and_return(OpenStruct.new(body: '{"name": "Madrid"}'))

      action.call(params)
    end
  end
end
