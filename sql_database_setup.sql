CREATE SCHEMA customer_management;
CREATE SCHEMA employee_management;
CREATE SCHEMA booking_system;

--- create customer schema tables
CREATE TABLE customer_management.customers(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	email VARCHAR NOT NULL,
	phone VARCHAR NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_management.customer_profiles (
    profile_id SERIAL PRIMARY KEY,
    customer_id INT UNIQUE,
    date_of_birth DATE,
    gender VARCHAR(10),

    CONSTRAINT fk_customer_profile
        FOREIGN KEY (customer_id)
        REFERENCES customer_management.customers(customer_id)
        ON DELETE CASCADE
);

--- create employee schema tables
CREATE TABLE employee_management.employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    role VARCHAR(50) NOT NULL,
    hired_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employee_management.departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE employee_management.employee_department (
    id SERIAL PRIMARY KEY,
    employee_id INT,
    department_id INT,

    CONSTRAINT fk_emp
        FOREIGN KEY (employee_id)
        REFERENCES employee_management.employees(employee_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_dept
        FOREIGN KEY (department_id)
        REFERENCES employee_management.departments(department_id)
        ON DELETE CASCADE,

    CONSTRAINT unique_emp_dept UNIQUE (employee_id, department_id)
);

--- create booking schema tables

CREATE TABLE booking_system.flights (
    flight_id SERIAL PRIMARY KEY,
    flight_number VARCHAR(20) UNIQUE NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL
);

CREATE TABLE booking_system.bookings (
    booking_id SERIAL PRIMARY KEY,
    customer_id INT,
    flight_id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer_management.customers(customer_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_flight
        FOREIGN KEY (flight_id)
        REFERENCES booking_system.flights(flight_id)
        ON DELETE CASCADE
);

CREATE TABLE booking_system.tickets (
    ticket_id SERIAL PRIMARY KEY,
    booking_id INT,
    seat_number VARCHAR(10) NOT NULL,

    CONSTRAINT fk_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking_system.bookings(booking_id)
        ON DELETE CASCADE
);

CREATE TABLE booking_system.checkins (
    checkin_id SERIAL PRIMARY KEY,
    booking_id INT UNIQUE,
    checkin_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_checkin_booking
        FOREIGN KEY (booking_id)
        REFERENCES booking_system.bookings(booking_id)
        ON DELETE CASCADE
);

--- customer_ratings

CREATE TABLE booking_system.customer_ratings (
    rating_id SERIAL PRIMARY KEY,
    customer_id INT,
    flight_id INT,
    employee_id INT,
    rating_value INT NOT NULL,
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_rating_customer
        FOREIGN KEY (customer_id)
        REFERENCES customer_management.customers(customer_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_rating_flight
        FOREIGN KEY (flight_id)
        REFERENCES booking_system.flights(flight_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_rating_employee
        FOREIGN KEY (employee_id)
        REFERENCES employee_management.employees(employee_id)
        ON DELETE SET NULL,

    CONSTRAINT rating_range CHECK (rating_value BETWEEN 1 AND 5)
);

--- Indexes (Performance Boost)

-- Customers
CREATE INDEX idx_customer_email
ON customer_management.customers(email);

-- Bookings
CREATE INDEX idx_booking_customer
ON booking_system.bookings(customer_id);

CREATE INDEX idx_booking_flight
ON booking_system.bookings(flight_id);

-- Ratings
CREATE INDEX idx_rating_customer
ON booking_system.customer_ratings(customer_id);

CREATE INDEX idx_rating_flight
ON booking_system.customer_ratings(flight_id);


--- we insert add self but in real connect app or software data get throungh.


INSERT INTO customer_management.customers (customer_id, first_name, last_name, email, phone) VALUES
(1,'cus_ali','khan','ali@mail.com','03001234567'),
(2,'cus_ahmed','raza','ahmed@mail.com','03011234567'),
(3,'cus_usman','ali','usman@mail.com','03111234567'),
(4,'cus_hassan','mehmood','hassan@mail.com','03211234567'),
(5,'cus_hamza','sheikh','hamza@mail.com','03311234567'),
(6,'cus_bilal','malik','bilal@mail.com','03331234567'),
(7,'cus_zain','khan','zain@mail.com','03451234567'),
(8,'cus_umer','farooq','umer@mail.com','03021234567'),
(9,'cus_faizan','ali','faizan@mail.com','03091234567'),
(10,'cus_talha','nadeem','talha@mail.com','03121234567'),
(11,'cus_arslan','baig','arslan@mail.com','03131234567'),
(12,'cus_imran','khan','imran@mail.com','03221234567'),
(13,'cus_shoaib','akhtar','shoaib@mail.com','03321234567'),
(14,'cus_waqas','ahmed','waqas@mail.com','03401234567'),
(15,'cus_saad','ali','saad@mail.com','03411234567'),
(16,'cus_junaid','khan','junaid@mail.com','03071234567'),
(17,'cus_danish','iqbal','danish@mail.com','03081234567'),
(18,'cus_rehan','malik','rehan@mail.com','03171234567'),
(19,'cus_adnan','raza','adnan@mail.com','03271234567'),
(20,'cus_yasir','hussain','yasir@mail.com','03371234567');

INSERT INTO customer_management.customer_profiles (profile_id, customer_id, date_of_birth, gender) VALUES
(1,1,'1995-05-10','male'),
(2,2,'1992-03-15','male'),
(3,3,'1994-07-20','male'),
(4,4,'1998-07-20','male'),
(5,5,'1990-01-01','male'),
(6,6,'1991-02-02','male'),
(7,7,'1996-06-06','male'),
(8,8,'1993-02-11','male'),
(9,9,'1997-09-09','male'),
(10,10,'1991-09-09','male'),
(11,11,'1994-04-14','male'),
(12,12,'1990-10-10','male'),
(13,13,'1988-08-08','male'),
(14,14,'1992-12-12','male'),
(15,15,'1997-12-12','male'),
(16,16,'1999-11-11','male'),
(17,17,'1993-03-03','male'),
(18,18,'1993-03-03','male'),
(19,19,'1992-02-02','male'),
(20,20,'1995-01-01','male');

INSERT INTO employee_management.employees (employee_id, first_name, last_name, role) VALUES
(1,'emp_ali','khan','pilot'),
(2,'emp_ahmed','raza','crew'),
(3,'emp_usman','ali','staff'),
(4,'emp_hassan','mehmood','crew'),
(5,'emp_hamza','sheikh','pilot'),
(6,'emp_bilal','malik','staff'),
(7,'emp_zain','khan','crew'),
(8,'emp_umer','farooq','staff'),
(9,'emp_faizan','ali','crew'),
(10,'emp_talha','nadeem','pilot'),
(11,'emp_arslan','baig','staff'),
(12,'emp_imran','khan','pilot'),
(13,'emp_shoaib','akhtar','crew'),
(14,'emp_waqas','ahmed','staff'),
(15,'emp_saad','ali','crew'),
(16,'emp_junaid','khan','pilot'),
(17,'emp_danish','iqbal','staff'),
(18,'emp_rehan','malik','crew'),
(19,'emp_adnan','raza','pilot'),
(20,'emp_yasir','hussain','staff');

INSERT INTO employee_management.departments (department_id, department_name) VALUES
(1,'operations'),
(2,'hr'),
(3,'maintenance'),
(4,'customer_service');

INSERT INTO employee_management.employee_department (id, employee_id, department_id) VALUES
(1,1,1),(2,2,4),(3,3,2),(4,4,4),(5,5,1),
(6,6,3),(7,7,4),(8,8,2),(9,9,4),(10,10,1),
(11,11,3),(12,12,1),(13,13,4),(14,14,2),(15,15,4),
(16,16,1),(17,17,3),(18,18,4),(19,19,1),(20,20,2);

INSERT INTO booking_system.flights (flight_id, flight_number, departure_time, arrival_time) VALUES
(1,'pk101','2026-05-01 10:00','2026-05-01 12:00'),
(2,'pk102','2026-05-01 13:00','2026-05-01 15:00'),
(3,'pk103','2026-05-02 09:00','2026-05-02 11:00'),
(4,'pk104','2026-05-02 14:00','2026-05-02 16:00'),
(5,'pk105','2026-05-03 08:00','2026-05-03 10:00'),
(6,'pk106','2026-05-03 11:00','2026-05-03 13:00'),
(7,'pk107','2026-05-04 07:00','2026-05-04 09:00'),
(8,'pk108','2026-05-04 15:00','2026-05-04 17:00'),
(9,'pk109','2026-05-05 10:00','2026-05-05 12:00'),
(10,'pk110','2026-05-05 18:00','2026-05-05 20:00'),
(11,'pk111','2026-05-06 06:00','2026-05-06 08:00'),
(12,'pk112','2026-05-06 12:00','2026-05-06 14:00'),
(13,'pk113','2026-05-07 09:00','2026-05-07 11:00'),
(14,'pk114','2026-05-07 16:00','2026-05-07 18:00'),
(15,'pk115','2026-05-08 08:00','2026-05-08 10:00'),
(16,'pk116','2026-05-08 13:00','2026-05-08 15:00'),
(17,'pk117','2026-05-09 07:00','2026-05-09 09:00'),
(18,'pk118','2026-05-09 17:00','2026-05-09 19:00'),
(19,'pk119','2026-05-10 10:00','2026-05-10 12:00'),
(20,'pk120','2026-05-10 19:00','2026-05-10 21:00');

INSERT INTO booking_system.bookings (booking_id, customer_id, flight_id) VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),
(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10),
(11,11,11),(12,12,12),(13,13,13),(14,14,14),(15,15,15),
(16,16,16),(17,17,17),(18,18,18),(19,19,19),(20,20,20);

INSERT INTO booking_system.tickets (ticket_id, booking_id, seat_number) VALUES
(1,1,'A1'),(2,2,'A2'),(3,3,'A3'),(4,4,'A4'),(5,5,'A5'),
(6,6,'B1'),(7,7,'B2'),(8,8,'B3'),(9,9,'B4'),(10,10,'B5'),
(11,11,'C1'),(12,12,'C2'),(13,13,'C3'),(14,14,'C4'),(15,15,'C5'),
(16,16,'D1'),(17,17,'D2'),(18,18,'D3'),(19,19,'D4'),(20,20,'D5');

INSERT INTO booking_system.checkins (checkin_id, booking_id, checkin_time) VALUES
(1,1,'2026-05-01 09:00'),
(2,2,'2026-05-01 12:00'),
(3,3,'2026-05-02 08:00'),
(4,4,'2026-05-02 13:00'),
(5,5,'2026-05-03 07:00'),
(6,6,'2026-05-03 10:00'),
(7,7,'2026-05-04 06:00'),
(8,8,'2026-05-04 14:00'),
(9,9,'2026-05-05 09:00'),
(10,10,'2026-05-05 17:00'),
(11,11,'2026-05-06 05:00'),
(12,12,'2026-05-06 11:00'),
(13,13,'2026-05-07 08:00'),
(14,14,'2026-05-07 15:00'),
(15,15,'2026-05-08 07:00'),
(16,16,'2026-05-08 12:00'),
(17,17,'2026-05-09 06:00'),
(18,18,'2026-05-09 16:00'),
(19,19,'2026-05-10 09:00'),
(20,20,'2026-05-10 18:00');

INSERT INTO booking_system.customer_ratings 
(rating_id, customer_id, flight_id, employee_id, rating_value, review) VALUES
(1,1,1,1,5,'excellent'),
(2,2,2,2,4,'good'),
(3,3,3,3,3,'average'),
(4,4,4,4,2,'poor'),
(5,5,5,5,5,'excellent'),
(6,6,6,6,4,'good'),
(7,7,7,7,3,'average'),
(8,8,8,8,5,'excellent'),
(9,9,9,9,2,'poor'),
(10,10,10,10,4,'good'),
(11,11,11,11,5,'excellent'),
(12,12,12,12,3,'average'),
(13,13,13,13,4,'good'),
(14,14,14,14,2,'poor'),
(15,15,15,15,5,'excellent'),
(16,16,16,16,4,'good'),
(17,17,17,17,3,'average'),
(18,18,18,18,5,'excellent'),
(19,19,19,19,4,'good'),
(20,20,20,20,2,'poor');


--- check all data

SELECT * FROM customer_management.customers;
SELECT * FROM customer_management.customer_profiles;
SELECT * FROM employee_management.employees;
SELECT * FROM employee_management.departments;
SELECT * FROM employee_management.employee_department;
SELECT * FROM booking_system.flights;
SELECT * FROM booking_system.bookings;
SELECT * FROM booking_system.checkins;
SELECT * FROM booking_system.customer_ratings;