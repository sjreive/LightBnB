SELECT reservations.*, properties.*, AVG(rating) as average_rating
FROM reservations
JOIN property_reviews ON reservation_id = reservations.id 
JOIN properties ON properties.id = property_reviews.property_id
WHERE end_date < now()::date
AND reservations.guest_id = 1
GROUP BY reservations.id, properties.id
ORDER BY reservations.start_date DESC
LIMIT 10;


