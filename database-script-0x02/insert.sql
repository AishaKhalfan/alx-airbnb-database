-- Drop tables if they exist
DROP TABLE IF EXISTS messages, reviews, payments, payment_methods, bookings, booking_statuses, properties, locations, users, roles;

-- Table: roles
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- Table: booking_statuses
CREATE TABLE booking_statuses (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

-- Table: payment_methods
CREATE TABLE payment_methods (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL UNIQUE
);

-- Table: users
CREATE TABLE users (
    user_id CHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Table: locations
CREATE TABLE locations (
    location_id CHAR(36) PRIMARY KEY,
    country VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    lat DECIMAL(10,6) NOT NULL,
    lng DECIMAL(10,6) NOT NULL
);

-- Table: properties
CREATE TABLE properties (
    property_id CHAR(36) PRIMARY KEY,
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location CHAR(36) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES users(user_id),
    FOREIGN KEY (location) REFERENCES locations(location_id)
);

-- Table: bookings
CREATE TABLE bookings (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (status_id) REFERENCES booking_statuses(status_id)
);

-- Table: payments
CREATE TABLE payments (
    payment_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (payment_method_id) REFERENCES payment_methods(method_id)
);

-- Table: reviews
CREATE TABLE reviews (
    review_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INT NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(property_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table: messages
CREATE TABLE messages (
    message_id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id),
    FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);

-- Indexes
CREATE INDEX users_email ON users(email);
CREATE INDEX bookings_property_id ON bookings(property_id);
CREATE INDEX payments_booking_id ON payments(booking_id);

-- Insert sample data

-- Roles
INSERT INTO roles (role_name) VALUES
('guest'),
('host'),
('admin');

-- Booking Statuses
INSERT INTO booking_statuses (status_name) VALUES
('pending'),
('confirmed'),
('canceled');

-- Payment Methods
INSERT INTO payment_methods (method_name) VALUES
('credit_card'),
('paypal'),
('stripe');

-- Users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role_id)
VALUES
('a1b2c3d4-e5f6-7a8b-9c0d-e1f2a3b4c5d6', 'Amina', 'Yusuf', 'amina@example.com', 'hashed_pw1', '0712345678', 1),
('b2c3d4e5-f6a7-8b9c-0d1e-f2a3b4c5d6e7', 'Khalid', 'Omar', 'khalid@example.com', 'hashed_pw2', '0723456789', 2),
('c3d4e5f6-a7b8-9c0d-1e2f-a3b4c5d6e7f8', 'Fatima', 'Ali', 'fatima@example.com', 'hashed_pw3', '0734567890', 3);

-- Locations
INSERT INTO locations (location_id, country, state, city, postal_code, lat, lng)
VALUES
('loc001', 'Kenya', 'Nairobi', 'Eastleigh', '00610', -1.283300, 36.833300),
('loc002', 'Tanzania', 'Dar es Salaam', 'Magomeni', '14112', -6.800000, 39.283300),
('loc003', 'Somalia', 'Banaadir', 'Mogadishu', '252', 2.046900, 45.318200);

-- Properties
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES
('prop001', 'b2c3d4e5-f6a7-8b9c-0d1e-f2a3b4c5d6e7', 'Al-Noor Apartments', 'Cozy space near the masjid.', 'loc001', 40.00),
('prop002', 'b2c3d4e5-f6a7-8b9c-0d1e-f2a3b4c5d6e7', 'Hijrah Haven', 'Family-friendly stay in a quiet Islamic neighborhood.', 'loc002', 35.50);

-- Bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status_id)
VALUES
('book001', 'prop001', 'a1b2c3d4-e5f6-7a8b-9c0d-e1f2a3b4c5d6', '2025-06-01', '2025-06-05', 160.00, 2),
('book002', 'prop002', 'a1b2c3d4-e5f6-7a8b-9c0d-e1f2a3b4c5d6', '2025-07-10', '2025-07-12', 71.00, 1);

-- Payments
INSERT INTO payments (payment_id, booking_id, amount, payment_method_id)
VALUES
('pay001', 'book001', 160.00, 1),
('pay002', 'book002', 71.00, 2);

-- Reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
('rev001', 'prop001', 'a1b2c3d4-e5f6-7a8b-9c0d-e1f2a3b4c5d6', 5, 'Mashallah, very clean and peaceful.'),
('rev002', 'prop002', 'a1b2c3d4-e5f6-7a8b-9c0d-e1f2a3b4c5d6', 4, 'Good stay, near halal restaurants.');

-- Messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
('msg001', 'a1b2c3d4-e5f6-7a8b-9c0d-e1f2a3b4c5d6', 'b2c3d4e5-f6a7-8b9c-0d1e-f2a3b4c5d6e7', 'As-salamu alaikum, is the property available next week?'),
('msg002', 'b2c3d4e5-f6a7-8b9c-0d1e-f2a3b4c5d6e7', 'a1b2c3d4-e5f6-7a8b-9c0d-e1f2a3b4c5d6', 'Wa alaikum salam, yes it is available from Monday.');

