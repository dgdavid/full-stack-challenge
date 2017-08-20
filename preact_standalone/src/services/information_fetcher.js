import axios from 'axios';
import config from '../config';
import { objectToQueryString } from '../utils';

/**
 * Service responsible to fetch information for city
 *
 * Collect information from external services to provide required
 * data to build the application user interface.
 *
 * Currently consuming:
 *
 *  - [OpenWeatherMap](http://openweathermap.org/) to get weather data and
 *    country code.
 *  - [REST Countries](https://restcountries.eu/) to retrieve country name and
 *    currency code.
 */
export default class InformationFetcher {

  /**
   * Perform request to fetch data
   *
   * @param {string} city - city for which is wanted to retrieve the information
   *
   * @todo rescue from errors
   *
   * @return {Object} data collected for a given city
   * @property {string} name the city name returned by OpenWeatherMap
   * @property {string} country country name, provided by RESTCountries
   * @property {string} currency currency code, provided by RESTCountries
   * @property {number} temperature provided by OpenWeatherMap
   * @property {string} condition_code the weather icon given by * OpenWeatherMap
   */
  async requestFor(city) {
    const weather = await this.getWeatherInformation(city);
    const country = await this.getCountryInformation(weather.sys.country);

    return {
      name: weather.name,
      country: country.name,
      currency: country.currencies[0].code,
      temperature: weather.main.temp,
      condition_code: weather.weather[0].icon
    };
  }

  /**
   * Make an OpenWeatherMap request
   *
   * @param {string} city - city name
   *
   * @return {Object} response from service
   */
  getWeatherInformation(city) {
    const options = { q: city, ...config.opw.options };
    const url = `${config.opw.url}?q=${city}&${objectToQueryString(options)}`;

    return axios.get(encodeURI(url))
      .then(response => response.data);
  }

  /**
   * Make a RESTCountries request
   *
   * @param {string} code - country code
   *
   * @return {Object} response from service
   */
  getCountryInformation(code) {
    const url = `${config.rc.url}/${code}`;

    return axios.get(encodeURI(url))
      .then(response => response.data);
  }
}
