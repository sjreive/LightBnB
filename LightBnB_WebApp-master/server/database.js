const properties = require('./json/properties.json');
const users = require('./json/users.json');
const { Pool } = require('pg');

const pool = new Pool({
  user: 'vagrant',
  password: 'vagrant',
  host: 'localhost',
  database: 'lightbnb'
});
/// Users

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithEmail = function(email) {
  return pool.query(
    `SELECT * 
    FROM users
    WHERE email = $1;`, [email]
  )
    .then(res => res.rows[0]);
};
  
exports.getUserWithEmail = getUserWithEmail;

/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function(id) {
  return pool.query(
    `SELECT * 
    FROM users
    WHERE users.id = $1;`, [id]
  )
    .then(res => res.rows[0]);
};
exports.getUserWithId = getUserWithId;


/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser =  function(user) {
  return pool.query(
    `INSERT INTO users (name, email, password)
    VALUES ($1, $2, $3)
    RETURNING *`, [user.name, user.email, user.password]
  )
    .then(res => res.rows[0]);
};
exports.addUser = addUser;

/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function(guest_id, limit = 10) {
  return pool.query(
    `SELECT reservations.*, properties.*, AVG(rating) as average_rating
    FROM reservations
    JOIN property_reviews ON reservation_id = reservations.id 
    JOIN properties ON properties.id = property_reviews.property_id
    WHERE end_date < now()::date
    AND reservations.guest_id = $1
    GROUP BY reservations.id, properties.id
    ORDER BY reservations.start_date DESC
    LIMIT $2;`, [guest_id, limit]
  )
    .then(res => res.rows);
};



exports.getAllReservations = getAllReservations;

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */
const getAllProperties = function(options, limit = 10) {

  // setup array to hold parameters available for the query
  const queryParams = [];

  // query prior to specifying params
  let queryString = `
  SELECT properties.*, AVG(rating) as average_rating
  FROM properties
  JOIN property_reviews on property_id = properties.id
  `;

  // Add options to query
  const checkParamLength = function(queryParams) {
    if (queryParams.length === 1) {
      return 'WHERE';
    } else {
      return 'AND';
    }
  };

  if (options.city) {
    queryParams.push(`%${options.city}%`);
    queryString += `${checkParamLength(queryParams)} city LIKE $${queryParams.length} `;
  }
  if (options.minimum_price_per_night) {
    queryParams.push(`${options.minimum_price_per_night * 100}`);
    queryString += `${checkParamLength(queryParams)} cost_per_night >= $${queryParams.length} `;
  }
  if (options.maximum_price_per_night) {
    queryParams.push(`${options.maximum_price_per_night * 100}`);
    queryString += `${checkParamLength(queryParams)} cost_per_night <= $${queryParams.length} `;
  }
  if (options.minimum_rating) {
    queryParams.push(`${options.minimum_rating}`);
    queryString += `${checkParamLength(queryParams)} average_rating > $${queryParams.length} `;
  }
  
  //Add query that comes after the WHERE + params
  queryParams.push(limit);
  queryString += `
  GROUP BY properties.id
  ORDER BY cost_per_night
  LIMIT $${queryParams.length}
  `;

  //Check
  console.log(queryString, queryParams);

  //Run query
  return pool.query(queryString, queryParams)
    .then(res => res.rows);
};

exports.getAllProperties = getAllProperties;


/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function(property) {
  const propertyId = Object.keys(properties).length + 1;
  property.id = propertyId;
  properties[propertyId] = property;
  return Promise.resolve(property);
};
exports.addProperty = addProperty;
