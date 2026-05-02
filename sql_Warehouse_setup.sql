CREATE SCHEMA warehouse;

CREATE TABLE warehouse.customers(
	customer_id NUMERIC,
	first_name VARCHAR,
	last_name VARCHAR,
	email VARCHAR,
	phone VARCHAR,
	created_at TIMESTAMP
);

CREATE TABLE warehouse.customer_profiles (
    profile_id NUMERIC,
    customer_id INT,
    date_of_birth DATE,
    gender VARCHAR
);

--- create employee schema tables
CREATE TABLE warehouse.employees (
    employee_id NUMERIC,
    first_name VARCHAR,
    last_name VARCHAR,
    role VARCHAR,
    hired_at TIMESTAMP
);

CREATE TABLE warehouse.departments (
    department_id NUMERIC,
    department_name VARCHAR
);

CREATE TABLE warehouse.employee_department (
    id NUMERIC,
    employee_id INT,
    department_id INT
);

--- create booking schema tables

CREATE TABLE warehouse.flights (
    flight_id NUMERIC,
    flight_number VARCHAR,
    departure_time TIMESTAMP,
    arrival_time TIMESTAMP
);

CREATE TABLE warehouse.bookings (
    booking_id NUMERIC,
    customer_id INT,
    flight_id INT,
    booking_date TIMESTAMP
);

CREATE TABLE warehouse.tickets (
    ticket_id NUMERIC,
    booking_id INT,
    seat_number VARCHAR
);

CREATE TABLE warehouse.checkins (
    checkin_id NUMERIC,
    booking_id INT,
    checkin_time TIMESTAMP
);

--- customer_ratings

CREATE TABLE warehouse.customer_ratings (
    rating_id NUMERIC,
    customer_id INT,
    flight_id INT,
    rating_value INT,
    review TEXT,
    created_at TIMESTAMP
);


--- After Run ETL data load automatically now we show one table

SELECT * FROM warehouse.customers