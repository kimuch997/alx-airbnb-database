# Airbnb Database ERD Requirements

## Entities and Attributes

### User
- **user_id** (PK, UUID, Indexed)
- **first_name** (VARCHAR, NOT NULL)
- **last_name** (VARCHAR, NOT NULL)
- **email** (VARCHAR, UNIQUE, NOT NULL)
- **password_hash** (VARCHAR, NOT NULL)
- **phone_number** (VARCHAR, NULL)
- **role** (ENUM: guest, host, admin, NOT NULL)
- **created_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Property
- **property_id** (PK, UUID, Indexed)
- **host_id** (FK → User.user_id)
- **name** (VARCHAR, NOT NULL)
- **description** (TEXT, NOT NULL)
- **location** (VARCHAR, NOT NULL)
- **pricepernight** (DECIMAL, NOT NULL)
- **created_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- **updated_at** (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

### Booking
- **booking_id** (PK, UUID, Indexed)
- **property_id** (FK → Property.property_id)
- **user_id** (FK → User.user_id)
- **start_date** (DATE, NOT NULL)
- **end_date** (DATE, NOT NULL)
- **total_price** (DECIMAL, NOT NULL)
- **status** (ENUM: pending, confirmed, canceled, NOT NULL)
- **created_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Payment
- **payment_id** (PK, UUID, Indexed)
- **booking_id** (FK → Booking.booking_id)
- **amount** (DECIMAL, NOT NULL)
- **payment_date** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- **payment_method** (ENUM: credit_card, paypal, stripe, NOT NULL)

### Review
- **review_id** (PK, UUID, Indexed)
- **property_id** (FK → Property.property_id)
- **user_id** (FK → User.user_id)
- **rating** (INTEGER, CHECK 1–5, NOT NULL)
- **comment** (TEXT, NOT NULL)
- **created_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Message
- **message_id** (PK, UUID, Indexed)
- **sender_id** (FK → User.user_id)
- **recipient_id** (FK → User.user_id)
- **message_body** (TEXT, NOT NULL)
- **sent_at** (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

---

## Relationships

- **User ↔ Property**: 1:N (one User/Host can list many Properties)
- **User ↔ Booking**: 1:N (one User/Guest can make many Bookings)
- **Property ↔ Booking**: 1:N (one Property can have many Bookings)
- **Booking ↔ Payment**: 1:N (one Booking can have many Payments)
- **User ↔ Review**: 1:N (one User/Guest can leave many Reviews)
- **Property ↔ Review**: 1:N (one Property can have many Reviews)
- **User ↔ Message**: 1:N (one User can send many Messages, also be recipient)

---

## Constraints
- **User Table**
  - Unique constraint on `email`
  - Non-null on required fields
- **Property Table**
  - Foreign key on `host_id`
- **Booking Table**
  - Foreign keys on `property_id`, `user_id`
  - `status` must be one of (pending, confirmed, canceled)
- **Payment Table**
  - Foreign key on `booking_id`
- **Review Table**
  - `rating` must be between 1 and 5
  - Foreign keys on `property_id`, `user_id`
- **Message Table**
  - Foreign keys on `sender_id`, `recipient_id`

---

## Indexing
- Primary Keys: automatically indexed
- Additional Indexes:
  - `email` in User table
  - `property_id` in Property and Booking tables
  - `booking_id` in Booking and Payment tables