require_relative '../../../../apps/front/views/city/show'

RSpec.describe Front::Views::City::Show do
  let(:template)  { Hanami::View::Template.new('apps/front/templates/city/show.html.erb') }
  let(:view)      { described_class.new(template, exposures) }
  let(:rendered)  { view.render }

  context 'When a city information is fetched' do
    let(:exposures) {
      {
        city: {
          'name' => 'Berlin',
          'country' => 'Germany',
          'temperature' => 9,
          'currency' => 'EUR'
        }
      }
    }

    it 'exposes #city' do
      expect(view.city).to eq exposures.fetch(:city)
    end

    it 'show city name' do
      expect(rendered).to match('Berlin')
    end

    it 'show country name' do
      expect(rendered).to match('Germany')
    end

    it 'show temperature' do
      expect(rendered).to match('9')
    end

    it 'show currency' do
      expect(rendered).to match('EUR')
    end
  end
end
