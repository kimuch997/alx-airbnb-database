# Airbnb Database Seed Data (Extended)

## Overview
This directory contains the SQL script to **populate the Airbnb database** with realistic sample data.  
It includes entries for users, properties, bookings, payments, reviews, and messages.

This extended version:
- Adds more users (guests and hosts)
- Adds more properties
- Adds multiple bookings (confirmed and pending)
- Adds payments linked to confirmed bookings
- Adds reviews
- Adds messages between users
- Explicitly sets `created_at` / `updated_at` timestamps for realism

---

## Files

| File Name | Description |
|-----------|-------------|
| `seed.sql` | SQL INSERT statements for seeding the database with extended sample data |
| `README.md` | This file, describing the seed data and usage |

## Usage

1. Make sure the **database schema** (`schema.sql`) has been created.This script should be executed after the schema.sql script has been run successfully
2. Open your SQL client and execute `seed.sql`:  
