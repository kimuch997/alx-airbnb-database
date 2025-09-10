-- ==============================
-- Airbnb Database Schema
-- Indexed columns that are likely to be searched frequently (email, property_id, booking_id).

-- ==============================

-- =============================

-- User Table 
-- Stores info about all users (guests,hosts and admins).
-- ==============================

CREATE TABLE Users(
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL CHECK (role IN('guest','host','admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON Users(email);

-- ===============================
-- Property Table
--Stores details about the properties listed by hosts
-- ===============================

CREATE TABLE Properties(
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(225) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(225) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES Users(user_id)

);

CREATE INDEX idx_properties_property_id ON Properties(property_id);

-- ===============================
-- Booking Table
-- Manages all booking records made by users for properties.
-- ===============================
CREATE TABLE Bookings(
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending','confirmed','canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_bookings_booking_id ON Bookings(booking_id);

-- ================================
-- Payments Table
-- Records payment details for each confirmed booking
-- ================================

CREATE TABLE Payments(
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card','paypal','stripe')),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)

);
CREATE INDEX idx_payments_booking_id ON Payments(booking_id);

-- ==============================
-- Review Table
-- Stores users review and ratings for properties after a booking.
-- ==============================

CREATE TABLE Reviews(
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Properties(property_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ===========================
-- Message Table 
-- Facilitates communication between users(e.g,guest to host).
-- ===========================

CREATE TABLE Messages (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (recipient_id) REFERENCES Users(user_id)
);

-- ===============================
-- Script End
-- ==============================