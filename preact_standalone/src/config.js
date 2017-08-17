const config = {
  defaultCity: 'Berlin',
  opw: {
    url: 'https://api.openweathermap.org/data/2.5/weather',
    options: {
      units: 'metric',
      appid: 'c22c1e116a64e88c7bf837212af83243'
    }
  },
  rc: {
    url: 'https://restcountries.eu/rest/v2/alpha'
  }
};

export default config;
