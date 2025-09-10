# Database Normalization Report for Airbnb Clone Project 

# Normalization is the process of org data to reduce redundancy and improve integrity.It involves dividng data into 2 or more tables and defining relationships btwn them

# Introduction 
# This document outlines the normalization process and confirmes that the database schema for the Airbnb Clone project adheres to the principles of Third Normal Form(3NF). The goal of normalization is to reduce data redundancy,prevent data anomlies(insertion,update,and delete anomilies), and ensure data integrity.

# Our database was structured from the onset to be compliant with these principles

## First Normal Form(1NF)
 **Rule:** A table is in 1NF if all its columns containe atomic (indivisible) values, and each record is unique.There should be no repeating groups of columns.

 **Application**
 All tables in our schema satisfy 1NF.
  -Each cell holds a single piece of information(e.g.the 'User' table has separate 'first_name' and 'last_name' columns,not a single 'full_name' column).
  -Each table has a unique Primary Key(e.g,'user_id','propery_id') which ensures that every row is unique


  ## Seconf Normal Form(2NF)

  **Rule** A table is in 2NF if it is in 1NF and all of its non-key attributes are fully functionally dependent on the entire primary key. This rule is primarily concerned with tables that have a composite primary key(a key made of 2 or more columns),in that all non-key attributes must depend on the composite key(both primary keys)

  **Applications:**
  All tables in our schema satisfy 1NF.
   -The primary key for every table ('User','Property','Booking',etc.) is a single column(e.g.,'user_id').
   -Since there no composite keys,there cannot be any partial dependancies.Therefore, the schema inherently meets the 2NF requirement.

   ## Third Normal Form(3NF)

   **Rule:** A table is in 3NF if it is in 2NF and has no transitive dependancies.A transitive dependancy exists when a non-key attribute is dependent on another non-key attribute, which in turn is dependant on the primary key.

   **Application:**
   All tables in our schema satisfy 3NF.
     -In each table,all non-key attributes depend directly and only on the primary key,not any other non-key attribute.
     -For example,in the 'Property' table, attributes like 'name','descriptions' and 'price_per_night' are all characteristics of a 'property_id'. The 'location' does not depend on the 'name';they both depend on the 'property_id'.
     -By separating entities like 'User','Property', and 'Booking' into their own tables,we have eliminated potential transitive dependancies.For instance,we don't store host details(like 'host_email') in the 'Property' table;instead,we use a foreign key 'host_id' that links to the 'User' table

## Conclusion 
The database schema for the Airbnb clone project is fully normalized to 3NF.This design ensures an efficient,reliable and scalable database structure,which is crucial for a production-level application
