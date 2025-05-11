
CREATE TABLE `users` (
  `user_id` uuid PRIMARY KEY,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) UNIQUE NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone_number` varchar(255),
  `role` ENUM ('guest', 'host', 'admin') NOT NULL,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `properties` (
  `property_id` uuid PRIMARY KEY,
  `host_id` uuid,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` uuid,
  `pricepernight` decimal NOT NULL,
  `created_at` timestamp DEFAULT (now()),
  `updated_at` timestamp COMMENT 'On Update set `now()'
);

CREATE TABLE `locations` (
  `location_id` uuid PRIMARY KEY,
  `country` varchar(255) NOT NULL,
  `state` varchar(255),
  `city` varchar(255),
  `postal_code` varchar(255),
  `lat` decimal NOT NULL,
  `lng` decimal NOT NULL
);

CREATE TABLE `bookings` (
  `booking_id` uuid PRIMARY KEY,
  `property_id` uuid,
  `user_id` uuid,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_price` decimal NOT NULL,
  `status` ENUM ('pending', 'confirmed', 'canceled') NOT NULL,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `payments` (
  `payment_id` uuid PRIMARY KEY,
  `booking_id` uuid,
  `amount` decimal NOT NULL,
  `payment_date` timestamp DEFAULT (now()),
  `payment_method` ENUM ('credit_card', 'paypal', 'stripe') NOT NULL
);

CREATE TABLE `reviews` (
  `review_id` uuid PRIMARY KEY,
  `property_id` uuid,
  `user_id` uuid,
  `rating` integer NOT NULL COMMENT '1 < value < 5',
  `comment` text NOT NULL,
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `messages` (
  `message_id` uuid PRIMARY KEY,
  `sender_id` uuid,
  `recipient_id` uuid,
  `message_body` text NOT NULL,
  `sent_at` timestamp DEFAULT (now())
);

CREATE INDEX `users_index_0` ON `users` (`email`);

CREATE INDEX `bookings_index_1` ON `bookings` (`property_id`);

CREATE INDEX `payments_index_2` ON `payments` (`booking_id`);

ALTER TABLE `properties` ADD FOREIGN KEY (`host_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `properties` ADD FOREIGN KEY (`location`) REFERENCES `locations` (`location_id`);

ALTER TABLE `bookings` ADD FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`);

ALTER TABLE `bookings` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `messages` ADD FOREIGN KEY (`sender_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `messages` ADD FOREIGN KEY (`recipient_id`) REFERENCES `users` (`user_id`);

