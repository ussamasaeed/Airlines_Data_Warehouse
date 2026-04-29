CREATE SCHEMA warehouse;

CREATE TABLE warehouse.customers(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	email VARCHAR NOT NULL,
	phone VARCHAR NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE warehouse.customer_profiles (
    profile_id SERIAL PRIMARY KEY,
    customer_id INT UNIQUE,
    date_of_birth DATE,
    gender VARCHAR(10),

    CONSTRAINT fk_customer_profile
        FOREIGN KEY (customer_id)
        REFERENCES warehouse.customers(customer_id)
        ON DELETE CASCADE
);

--- create employee schema tables
CREATE TABLE warehouse.employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    role VARCHAR(50) NOT NULL,
    hired_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE warehouse.departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE warehouse.employee_department (
    id SERIAL PRIMARY KEY,
    employee_id INT,
    department_id INT,

    CONSTRAINT fk_emp
        FOREIGN KEY (employee_id)
        REFERENCES warehouse.employees(employee_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_dept
        FOREIGN KEY (department_id)
        REFERENCES warehouse.departments(department_id)
        ON DELETE CASCADE,

    CONSTRAINT unique_emp_dept UNIQUE (employee_id, department_id)
);

--- create booking schema tables

CREATE TABLE warehouse.flights (
    flight_id SERIAL PRIMARY KEY,
    flight_number VARCHAR(20) UNIQUE NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL
);

CREATE TABLE warehouse.bookings (
    booking_id SERIAL PRIMARY KEY,
    customer_id INT,
    flight_id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES warehouse.customers(customer_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_flight
        FOREIGN KEY (flight_id)
        REFERENCES warehouse.flights(flight_id)
        ON DELETE CASCADE
);

CREATE TABLE warehouse.tickets (
    ticket_id SERIAL PRIMARY KEY,
    booking_id INT,
    seat_number VARCHAR(10) NOT NULL,

    CONSTRAINT fk_booking
        FOREIGN KEY (booking_id)
        REFERENCES warehouse.bookings(booking_id)
        ON DELETE CASCADE
);

CREATE TABLE warehouse.checkins (
    checkin_id SERIAL PRIMARY KEY,
    booking_id INT UNIQUE,
    checkin_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_checkin_booking
        FOREIGN KEY (booking_id)
        REFERENCES warehouse.bookings(booking_id)
        ON DELETE CASCADE
);

--- customer_ratings

CREATE TABLE warehouse.customer_ratings (
    rating_id SERIAL PRIMARY KEY,
    customer_id INT,
    flight_id INT,
    employee_id INT,
    rating_value INT NOT NULL,
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_rating_customer
        FOREIGN KEY (customer_id)
        REFERENCES warehouse.customers(customer_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_rating_flight
        FOREIGN KEY (flight_id)
        REFERENCES warehouse.flights(flight_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_rating_employee
        FOREIGN KEY (employee_id)
        REFERENCES warehouse.employees(employee_id)
        ON DELETE SET NULL,

    CONSTRAINT rating_range CHECK (rating_value BETWEEN 1 AND 5)
);