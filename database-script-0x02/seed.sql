-- ======================================
-- Airbnb Database Seed Data
-- This script populates the database with realistic sample data.
-- It should be run AFTER the schema.sql script has been executed.
-- We are using hardcoded UUIDs for consistency and to ensure
-- relationships between tables are correctly established.
-- ======================================

-- To generate new UUIDs, you can use an online generator or
-- the uuid-ossp extension in PostgreSQL with the uuid_generate_v4() function.


-- =================================================================
-- Step 1: Clear Existing Data (Optional but Recommended)
-- =================================================================
-- This ensures that if you run the script multiple times, you won't
-- create duplicate data. The order is reversed from creation.
DELETE FROM Messages;
DELETE FROM Reviews;
DELETE FROM Payments;
DELETE FROM Bookings;
DELETE FROM Properties;
DELETE FROM Users;


-- ==============================
-- Step 2: Insert Sample Users
-- ==============================
-- Creating a few users with different roles (host, guest, admin).

INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role,created_at)
VALUES
('11111111-1111-1111-1111-111111111111', 'Alice', 'Johnson', 'alice@example.com', 'hashedpwd1', '0712345678', 'guest'),
('22222222-2222-2222-2222-222222222222', 'Bob', 'Smith', 'bob@example.com', 'hashedpwd2', '0723456789', 'host'),
('33333333-3333-3333-3333-333333333333', 'Charlie', 'Brown', 'charlie@example.com', 'hashedpwd3', '0734567890', 'admin');

-- Additional users
('44444444-4444-4444-4444-444444444444', 'Diana', 'King', 'diana@example.com', 'hashedpwd4', '0745678901', 'guest', '2025-01-04 09:30:00'),
('55555555-5555-5555-5555-555555555555', 'Ethan', 'Lee', 'ethan@example.com', 'hashedpwd5', '0756789012', 'guest', '2025-01-05 08:45:00'),
('66666666-6666-6666-6666-666666666666', 'Fiona', 'Adams', 'fiona@example.com', 'hashedpwd6', '0767890123', 'host', '2025-01-06 14:15:00');

-- ==============================
--  Step 3: Insert Sample Properties
-- ==============================
-- Properties are linked to the hosts created above.


INSERT INTO Properties (property_id, host_id, name, description, location, pricepernight,created_at, updated_at)
VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '22222222-2222-2222-2222-222222222222', 'Cozy Apartment', 'A small cozy apartment in the city center', 'Nairobi', 50.00),
('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '22222222-2222-2222-2222-222222222222', 'Beach House', 'A beautiful beach house with sea view', 'Mombasa', 120.00);

-- Additional properties
('aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', '66666666-6666-6666-6666-666666666666', 'Mountain Cabin', 'Cabin with mountain view and fireplace', 'Nakuru', 80.00, '2025-02-03 12:30:00', '2025-02-03 12:30:00'),
('aaaaaaa4-aaaa-aaaa-aaaa-aaaaaaaaaaa4', '66666666-6666-6666-6666-666666666666', 'City Loft', 'Modern loft apartment in downtown', 'Nairobi', 70.00, '2025-02-04 09:15:00', '2025-02-04 09:15:00');


-- ==============================
-- Step 4: Insert Sample Bookings
-- total_price in bookings = pricepernight * number_of_nights for realism.
-- ==============================
-- A booking made by a guest for one of the properties.


INSERT INTO Bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status,created_at)
VALUES
('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', '2025-09-15', '2025-09-18', 150.00, 'confirmed'),
('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '11111111-1111-1111-1111-111111111111', '2025-10-01', '2025-10-05', 480.00, 'pending');

-- Additional bookings
('bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3', 'aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', '44444444-4444-4444-4444-444444444444', '2025-09-20', '2025-09-23', 240.00, 'confirmed', '2025-08-10 09:30:00'),
('bbbbbbb4-bbbb-bbbb-bbbb-bbbbbbbbbbb4', 'aaaaaaa4-aaaa-aaaa-aaaa-aaaaaaaaaaa4', '55555555-5555-5555-5555-555555555555', '2025-09-25', '2025-09-28', 210.00, 'pending', '2025-08-12 14:00:00');

-- ==============================
--  Step 5: Insert Sample Payments
-- Payments are linked to confirmed bookings only.
-- ==============================

INSERT INTO Payments (payment_id, booking_id, amount, payment_method,payment_date)
VALUES
('ccccccc1-cccc-cccc-cccc-ccccccccccc1', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 150.00, 'credit_card');
('ccccccc2-cccc-cccc-cccc-ccccccccccc2', 'bbbbbbb3-bbbb-bbbb-bbbb-bbbbbbbbbbb3', 240.00, 'paypal', '2025-08-20 11:00:00');


-- ==============================
--  Step 6: Insert Sample Reviews
-- ==============================
-- A review from the guest for the completed booking.


INSERT INTO Reviews (review_id, property_id, user_id, rating, comment)
VALUES
('ddddddd1-dddd-dddd-dddd-ddddddddddd1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', 5, 'Excellent stay! Very cozy and clean.');
('ddddddd2-dddd-dddd-dddd-ddddddddddd2', 'aaaaaaa3-aaaa-aaaa-aaaa-aaaaaaaaaaa3', '44444444-4444-4444-4444-444444444444', 4, 'Great mountain cabin, loved the view.', '2025-09-24 09:00:00');


-- ==============================
-- Step 7: Insert Sample Messages
-- ==============================
-- A message thread between the guest and the host.

INSERT INTO Messages (message_id, sender_id, recipient_id, message_body)
VALUES
('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hi Bob, I have a question about your property.'),
('eeeeeee2-eeee-eeee-eeee-eeeeeeeeeee2', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Hi Alice, sure! What would you like to know?');

('eeeeeee3-eeee-eeee-eeee-eeeeeeeeeee3', '44444444-4444-4444-4444-444444444444', '66666666-6666-6666-6666-666666666666', 'Hello Fiona, is your cabin available?', '2025-08-11 09:30:00'),
('eeeeeee4-eeee-eeee-eeee-eeeeeeeeeee4', '66666666-6666-6666-6666-666666666666', '44444444-4444-4444-4444-444444444444', 'Hi Diana, yes! Check the calendar for availability.', '2025-08-11 09:45:00');
-- =================================================================
-- Script End
-- =================================================================