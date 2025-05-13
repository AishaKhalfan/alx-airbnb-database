-- Table: roles (replaces enum role)
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR UNIQUE NOT NULL
);

-- Table: users
CREATE TABLE users (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR,
    role_id INT NOT NULL REFERENCES roles(role_id),
    created_at TIMESTAMP DEFAULT now()
);


-- Table: properties
CREATE TABLE properties (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL REFERENCES users(user_id),
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location UUID NOT NULL REFERENCES locations(location_id),
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- Table: booking_statuses (replaces enum booking_status)
CREATE TABLE booking_statuses (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR UNIQUE NOT NULL
);

-- Table: bookings
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES properties(property_id),
    user_id UUID NOT NULL REFERENCES users(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status_id INT NOT NULL REFERENCES booking_statuses(status_id),
    created_at TIMESTAMP DEFAULT now()
);

-- Table: payment_methods (replaces enum payment_method)
CREATE TABLE payment_methods (
    method_id SERIAL PRIMARY KEY,
    method_name VARCHAR UNIQUE NOT NULL
);

-- Table: payments
CREATE TABLE payments (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL REFERENCES bookings(booking_id),
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT now(),
    payment_method_id INT NOT NULL REFERENCES payment_methods(method_id)
);

-- Table: reviews
CREATE TABLE reviews (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL REFERENCES properties(property_id),
    user_id UUID NOT NULL REFERENCES users(user_id),
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

-- Table: messages
CREATE TABLE messages (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL REFERENCES users(user_id),
    recipient_id UUID NOT NULL REFERENCES users(user_id),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT now()
);

-- Indexes
CREATE INDEX users_email ON users(email);
CREATE INDEX bookings_property_id ON bookings(property_id);
CREATE INDEX payments_booking_id ON payments(booking_id);


