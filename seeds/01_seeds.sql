INSERT INTO users (id, name, email, password)
VALUES (1, 'Joan Green', 'joangreen@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
(2, 'Tupac', 'tupac@gmail.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u'),
(3, 'Mr. Smith', 'iamsmith@email.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u');

INSERT INTO properties (id, owner_id, title, description, thumbnail_photo_url, cover_photo_url, cost_per_night, parking_spaces, number_of_bathrooms, number_of_bedrooms, country, street, city, province, post_code, active)
VALUES (1, 1, 'Title', 'DESCRIPTION', 'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg?auto=compress&cs=tinysrgb&h=350', 'https://images.pexels.com/photos/2086676/pexels-photo-2086676.jpeg', 950, 2, 2, 4, 'Canada', '435 Namsub Highway', 'Sotboske', 'Ontario', '281942', true),
(2, 2, 'Title', 'Its a hotel, motel, holiday inn!', 'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg?auto=compress&cs=tinysrgb&h=350', 'https://images.pexels.com/photos/2080018/pexels-photo-2080018.jpeg', 1000, 8, 8, 12, 'Canada', '6969 Cool St', 'CoolTown', 'Yukon', '420', true),
(3, 3, 'Title', 'Generic house', 'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&h=350', 'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg', 1, 1, 1, 1, 'Canada', '1 Street St', 'City of City', 'Province', '22222', true);

INSERT INTO reservations (id, guest_id, property_id, start_date, end_date)
VALUES (1, 1, 1, '2018-08-11', '2018-08-26'),
(2, 2, 2, '2019-03-04', '2019-06-01'),
(3, 3, 3, '2019-10-01', '2019-10-14');

INSERT INTO property_reviews (id, guest_id, reservation_id, property_id, rating, message)
VALUES (1, 1, 2, 3, 3, 'message'),
(2, 2, 3, 1, 5, 'message'),
(3, 3, 1, 2, 3, 'message');