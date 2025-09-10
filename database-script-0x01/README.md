# Airbnb Database Schema (SQL)

## Overview

This directory contains the SQL script to create the **Airbnb database schema**.  
The schema defines all necessary tables, primary keys, foreign keys, constraints, and indexes based on the Airbnb database specification.

The schema is designed to manage:

- Users (guests, hosts, admins)
- Properties listed by hosts
- Bookings made by users
- Payments for confirmed bookings
- Reviews left by users
- Messages exchanged between users

---

## Files

| File Name      | Description |
|----------------|-------------|
| `schema.sql`   | Contains the SQL `CREATE TABLE` statements, constraints, and indexes. |
| `README.md`    | This file, describing the schema and how to use it. |

---

## Tables and Constraints

### Users
- Stores all users (guests, hosts, admins)  
- Columns: `user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`  
- Constraints: Primary key (`user_id`), unique `email`, check constraint on `role`  
- Indexed column: `email`

### Properties
- Stores properties listed by hosts  
- Columns: `property_id`, `host_id`, `name`, `description`, `location`, `priceper_night`, `created_at`, `updated_at`  
- Constraints: Primary key (`property_id`), foreign key (`host_id`) references `Users`  
- Indexed column: `property_id`

### Bookings
- Stores bookings for properties  
- Columns: `booking_id`, `property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `created_at`  
- Constraints: Primary key (`booking_id`), foreign keys (`property_id` → `Properties`, `user_id` → `Users`), check constraint on `status`  
- Indexed columns: `booking_id`, `property_id`

### Payments
- Stores payment details for confirmed bookings  
- Columns: `payment_id`, `booking_id`, `amount`, `payment_date`, `payment_method`  
- Constraints: Primary key (`payment_id`), foreign key (`booking_id` → `Bookings`), check constraint on `payment_method`  
- Indexed column: `booking_id`

### Reviews
- Stores ratings and reviews for properties  
- Columns: `review_id`, `property_id`, `user_id`, `rating`, `comment`, `created_at`  
- Constraints: Primary key (`review_id`), foreign keys (`property_id` → `Properties`, `user_id` → `Users`), check constraint on `rating`

### Messages
- Stores messages between users  
- Columns: `message_id`, `sender_id`, `recipient_id`, `message_body`, `sent_at`  
- Constraints: Primary key (`message_id`), foreign keys (`sender_id` & `recipient_id` → `Users`)

---

## How to Use

1. Open your preferred SQL client (MySQL, PostgreSQL, or SQLite with minor adjustments).  
2. Execute the script `schema.sql` to create all tables, constraints, and indexes:  

```sql
-- Example for MySQL or PostgreSQL
SOURCE path/to/schema.sql;
