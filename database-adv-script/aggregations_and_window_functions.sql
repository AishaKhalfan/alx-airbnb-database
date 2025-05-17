--Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT
  users.user_id,
  users.first_name,
  users.last_name,
  users.email,
  COUNT(bookings.booking_id) AS total_bookings
FROM
  users
  LEFT JOIN bookings ON bookings.user_id = users.user_id
GROUP BY
 users.user_id,
  users.first_name,
  users.last_name,
  users.email;

--Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
WITH property_counts AS (
  SELECT
    properties.property_id,
    properties.name AS property_name,
    COUNT(bookings.booking_id) AS total_bookings
  FROM
    properties
    LEFT JOIN bookings ON bookings.property_id = properties.property_id
  GROUP BY
    properties.property_id,
    properties.name
)
SELECT
  property_id,
  property_name,
  total_bookings,
  RANK() OVER (ORDER BY total_bookings DESC) AS rank
FROM property_counts;

