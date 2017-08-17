import { h, Component } from 'preact';

/**
 * Component responsible to request and render information
 */
export default class CityInformation extends Component {
  state = {
    name: undefined,
    country: undefined,
    currency: undefined,
    temperature: undefined,
    weatherCode: undefined
  };

  componentWillMount() {
    this.setState({ name: this.props.name });
  }

  render({}, { name, country, currency, temperature, weatherCode }) {
    return (
      <div class="wrapper">
        <i class={`weather-condition c${weatherCode}`}></i>
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
