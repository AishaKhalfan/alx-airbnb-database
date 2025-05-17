--Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.

select bookings.booking_id, property_id, users.first_name from bookings inner join users on bookings.user_id = us                               ers.user_id;

--Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.

select properties.name, reviews.comment, name from properties left join reviews on properties.property_id = reviews.property_id;

--Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user. 

-- Simulated FULL OUTER JOIN between users and bookings

-- Part 1: All users and their bookings (if any)
SELECT
  users.user_id,
  users.first_name,
  users.last_name,
  users.email,
  users.phone_number,
  users.role,
  users.created_at AS user_created_at,
  bookings.booking_id,
  bookings.property_id,
  bookings.start_date,
  bookings.end_date,
  bookings.total_price,
  bookings.status,
  bookings.created_at AS booking_created_at
FROM
  users
LEFT JOIN
  bookings ON users.user_id = bookings.user_id

UNION

-- Part 2: All bookings not linked to any user
SELECT
  users.user_id,
  users.first_name,
  users.last_name,
  users.email,
  users.phone_number,
  users.role,
  users.created_at AS user_created_at,
  bookings.booking_id,
  bookings.property_id,
  bookings.start_date,
  bookings.end_date,
  bookings.total_price,
  bookings.status,
  bookings.created_at AS booking_created_at
FROM
  bookings
LEFT JOIN
  users ON users.user_id = bookings.user_id
WHERE
  users.user_id IS NULL;




