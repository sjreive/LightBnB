CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE properties (
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  thumbnail_photo_url VARCHAR(255),
  cover_photo_url VARCHAR(255),
  cost_per_night MONEY NOT NULL,
  street VARCHAR(255) NOT NULL,
  parking_spaces SMALLINT,
  number_of_bathrooms SMALLINT NOT NULL,
  number_of_bedrooms SMALLINT NOT NULL,
  country VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  province VARCHAR(255) NOT NULL,
  post_code VARCHAR(50) NOT NULL,
  active BOOL NOT NULL
);

CREATE TABLE reservations (
  id SERIAL PRIMARY KEY NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  property_id INTEGER NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
  guest_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE property_reviews (
id SERIAL PRIMARY KEY NOT NULL,
guest_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
reservation_id INTEGER NOT NULL REFERENCES reservations(id) ON DELETE CASCADE,
property_id INTEGER NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
rating SMALLINT NOT NULL,
message TEXT
);
