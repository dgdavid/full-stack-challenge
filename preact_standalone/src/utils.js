/**
 * Build a query string with given params
 *
 * @param {Object} params
 *
 * @return {string} a query string
 */
export const objectToQueryString = (params) =>
  Object.keys(params).map(key => `${key}=${params[key]}`).join('&');
