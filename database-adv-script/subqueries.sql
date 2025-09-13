-- ============================================================
-- Airbnb Clone Project - Subqueries
-- File: subqueries.sql
-- Purpose: Demonstrate correlated and non-correlated subqueries
-- ============================================================

-- ============================================================
-- 1. Non-Correlated Subquery
-- ============================================================
-- Goal: Find all properties where the average rating is greater than 4.0.
-- Explanation:
--   - The subquery computes average ratings grouped by property.
--   - The outer query selects properties whose property_id is in that result set.
-- ============================================================

SELECT 
    p.property_id,
    p.name AS property_name,
    p.description
FROM Property p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM Review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);


-- ============================================================
-- 2. Correlated Subquery
-- ============================================================
-- Goal: Find users who have made more than 3 bookings.
-- Explanation:
--   - A correlated subquery runs once per row of the outer query.
--   - For each user, we count their bookings.
--   - If the count > 3, that user qualifies.
-- ============================================================

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3;
