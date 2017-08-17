import { h, Component } from 'preact';

import City from '../../components/city';
import Currency from '../../components/currency';
import Temperature from '../../components/temperature';
import WeatherIcon from '../../components/weather_icon';

import InformationFetcher from '../../services/information_fetcher';

/**
 * Component responsible to request and render information
 */
export default class CityInformation extends Component {
  state = {
    name: undefined,
    country: undefined,
    currency: undefined,
    temperature: undefined,
    condition_code: undefined // For simplicity reasons the key from api is kept
  };

  componentWillMount() {
    const fetcher = new InformationFetcher();
    this.setState({ name: this.props.name });

    fetcher.requestFor(this.props.name)
      .then(result => this.setState(result));
  }

  render({}, { name, country, currency, temperature, condition_code }) {
    return (
      <div class="wrapper">
        <WeatherIcon code={condition_code} />
        <City name={name} country={country} />
        <Temperature value={temperature} />
        <Currency code={currency} />
      </div>
    );
  }
}
