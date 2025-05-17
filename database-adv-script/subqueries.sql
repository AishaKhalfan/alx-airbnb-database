-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.

SELECT 
  properties.property_id,
  properties.name AS property_name
FROM 
  properties
WHERE 
  (
    SELECT AVG(reviews.rating)
    FROM reviews
    WHERE reviews.property_id = properties.property_id
  ) > 4.0;

--Write a correlated subquery to find users who have made more than 3 bookings.
SELECT 
  users.user_id,
  users.first_name,
  users.last_name,
  users.email
FROM 
  users
WHERE 
  (
    SELECT COUNT(*)
    FROM bookings
    WHERE bookings.user_id = users.user_id
  ) > 3;

