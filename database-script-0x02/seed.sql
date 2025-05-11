CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
-- Insert sample users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(UUID(), 'Aisha', 'Khalifan', 'aisha@example.com', 'hashedpassword1', '0712345678', 'host'),
(UUID(), 'Omar', 'Hussein', 'omar@example.com', 'hashedpassword2', '0723456789', 'guest'),
(UUID(), 'Fatima', 'Abdi', 'fatima@example.com', 'hashedpassword3', NULL, 'admin');

-- Insert sample locations
INSERT INTO locations (location_id, country, state, city, postal_code, lat, lng)
VALUES
(UUID(), 'Kenya', 'Nairobi', 'Nairobi', '00100', -1.2921, 36.8219),
(UUID(), 'Turkey', 'Istanbul', 'Istanbul', '34000', 41.0082, 28.9784);

-- Insert sample properties
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES
(UUID(), (SELECT user_id FROM users WHERE email='aisha@example.com'), 'Modern Nairobi Apartment', 'Spacious apartment near city center', (SELECT location_id FROM locations WHERE city='Nairobi'), 85.00),
(UUID(), (SELECT user_id FROM users WHERE email='aisha@example.com'), 'Sultan View Flat', 'Flat with a great view of the Bosphorus', (SELECT location_id FROM locations WHERE city='Istanbul'), 130.00);

-- Insert sample bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(UUID(), (SELECT property_id FROM properties WHERE name='Modern Nairobi Apartment'), (SELECT user_id FROM users WHERE email='omar@example.com'), '2025-05-20', '2025-05-25', 425.00, 'confirmed'),
(UUID(), (SELECT property_id FROM properties WHERE name='Sultan View Flat'), (SELECT user_id FROM users WHERE email='omar@example.com'), '2025-06-01', '2025-06-03', 260.00, 'pending');

-- Insert sample payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
(UUID(), (SELECT booking_id FROM bookings WHERE total_price = 425.00), 425.00, 'paypal');

-- Insert sample reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
(UUID(), (SELECT property_id FROM properties WHERE name='Modern Nairobi Apartment'), (SELECT user_id FROM users WHERE email='omar@example.com'), 5, 'MashaAllah, beautiful place and peaceful!'),
(UUID(), (SELECT property_id FROM properties WHERE name='Sultan View Flat'), (SELECT user_id FROM users WHERE email='omar@example.com'), 4, 'Very clean and close to masjid.');

-- Insert sample messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
(UUID(), (SELECT user_id FROM users WHERE email='omar@example.com'), (SELECT user_id FROM users WHERE email='aisha@example.com'), 'Asalaamu Alaikum, is Sultan View Flat available in June?'),
(UUID(), (SELECT user_id FROM users WHERE email='aisha@example.com'), (SELECT user_id FROM users WHERE email='omar@example.com'), 'Wa Alaikum Salaam, yes it’s available. Please go ahead and book.');

