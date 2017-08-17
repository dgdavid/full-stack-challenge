import { h, Component } from 'preact';
import axios from 'axios';
import config from '../../config';

import City from '../../components/city';
import Currency from '../../components/currency';
import Temperature from '../../components/temperature';
import WeatherIcon from '../../components/weather_icon';

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
    this.setState({ name: this.props.name });

    axios.get(encodeURI(`${config.apiUrl}/${this.props.name}`))
      .then(response => this.setState(response.data))
      .catch(error => {
        // Log error only in development mode
      });
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
