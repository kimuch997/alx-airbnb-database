# Complex Queries with Joins

This directory contains SQL scripts demonstrating the use of **INNER JOIN**, **LEFT JOIN**, and **FULL OUTER JOIN** in the context of the Airbnb Clone database.

## Queries

1. **INNER JOIN**
   - Retrieves all bookings and the respective users who made those bookings.
   - Ensures only records with matches in both `Booking` and `User` are included.

2. **LEFT JOIN**
   - Retrieves all properties and their reviews.
   - Includes properties even if they have no reviews.

3. **FULL OUTER JOIN**
   - Retrieves all users and all bookings.
   - Ensures no record is left out, even if:
     - A user has no bookings, or
     - A booking is not linked to a user.
   - Implemented directly if using PostgreSQL.
   - If using MySQL, simulated using a combination of **LEFT JOIN** and **RIGHT JOIN** with `UNION`.

## Files
- `joins_queries.sql` → Contains all the SQL queries.
- `README.md` → Documentation of the queries.

## Subqueries

This section demonstrates **non-correlated** and **correlated subqueries**.

### 1. Non-Correlated Subquery
Query to find properties where the **average rating > 4.0**:
- Inner query calculates average rating per property.
- Outer query selects properties with IDs returned by the subquery.

### 2. Correlated Subquery
Query to find users with **more than 3 bookings**:
- For each user, the subquery counts their bookings.
- The condition filters users with count > 3.
