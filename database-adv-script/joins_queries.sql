-- ============================================================
-- Airbnb Clone Project - Complex Joins
-- File: joins_queries.sql
-- Purpose: Demonstrate INNER JOIN, LEFT JOIN, and FULL OUTER JOIN
-- ============================================================

-- ============================================================
-- 1. INNER JOIN
-- ============================================================
-- INNER JOIN returns rows that have matching values in BOTH tables.
-- In our Airbnb schema:
--   - We want to retrieve bookings along with the users who made them.
--   - A booking must always have a user, so this will give us clean matched data.
-- ============================================================

SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM Booking b
INNER JOIN User u
    ON b.user_id = u.user_id;


-- ============================================================
-- 2. LEFT JOIN
-- ============================================================
-- LEFT JOIN returns ALL records from the "left" table,
-- and the matched records from the "right" table.
-- If there is no match, the result from the right table is NULL.
--
-- In our Airbnb schema:
--   - We want to retrieve all properties and their reviews.
--   - Some properties may not have any reviews yet.
--   - LEFT JOIN ensures those properties are still included,
--     with NULL values for review fields.
-- ============================================================

SELECT 
    p.property_id,
    p.name AS property_name,
    p.description,
    r.review_id,
    r.rating,
    r.comment
FROM Property p
LEFT JOIN Review r
    ON p.property_id = r.property_id;


-- ============================================================
-- 3. FULL OUTER JOIN
-- ============================================================
-- FULL OUTER JOIN returns ALL records when there is a match in
-- either the left or right table.
-- If there is no match:
--   - Non-matching rows from the left table still appear (with NULLs for the right).
--   - Non-matching rows from the right table still appear (with NULLs for the left).
--
-- In our Airbnb schema:
--   - We want to see ALL users and ALL bookings.
--   - This ensures:
--       • Users with no bookings are included.
--       • Bookings without a valid user (rare, but possible with bad data) are included.
--
-- NOTE: MySQL does NOT support FULL OUTER JOIN directly.
--       We simulate it by combining LEFT JOIN and RIGHT JOIN with UNION.
-- ============================================================

-- PostgreSQL (direct support for FULL OUTER JOIN):
-- SELECT 
--     u.user_id,
--     u.first_name,
--     u.last_name,
--     b.booking_id,
--     b.property_id,
--     b.start_date,
--     b.end_date
-- FROM User u
-- FULL OUTER JOIN Booking b
--     ON u.user_id = b.user_id;

-- MySQL (simulation using UNION of LEFT and RIGHT JOINs):
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM User u
LEFT JOIN Booking b
    ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM User u
RIGHT JOIN Booking b
    ON u.user_id = b.user_id;
