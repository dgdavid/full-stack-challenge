import { h, Component } from 'preact';
import axios from 'axios';

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

    axios.get(`http://localhost:2300/api/city/${this.props.name}`)
      .then(response => this.setState(response.data))
      .catch(error => {
        // Log error only in development mode
      });
  }

  render({}, { name, country, currency, temperature, condition_code }) {
    return (
      <div class="wrapper">
        <i class={`weather-condition c${condition_code}`}></i>
        <div class="city-information">
          <span class="city-name">{ name }, </span>
          <span class="country-name">{ country }</span>
        </div>
        <div class="temperature">{ temperature } deg</div>
        <div class="currency">
          <span class="caption">Currency: </span>
          <span>{ currency }</span>
        </div>
      </div>
    );
  }
}
