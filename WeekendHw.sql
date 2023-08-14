drop table if exists service_ticket;
drop table if exists invoice;
drop table if exists sales_person;
drop table if exists customer;
drop table if exists car;
drop table if exists mechanic;









create table sales_person(
	sales_person_id int primary key not null,
	first_name char(100) not null,
	last_name char(100) not null,
	email char(20) not null,
	phone_number char(20) not null,
	salary decimal not null
);

create table car(
	SN char(100) primary key not null,
	model char(20) not null,
	color char(50) not null,
	car_year int not null,
	make char(15) not null,
	price decimal not null
);

create table customer(
	customer_id int primary key not null,
	first_name char(100) not null,
	last_name char(100) not null,
	phone_number char(50) not null,
	email char(50) not null,
	street_address char(20),
	city char(50),
	state char(15),
	zip_code char(10)
);

create table mechanic(
	mechanic_id int primary key not null,
	first_name char(100) not null,
	last_name char(100) not null,
	email char(50) not null,
	phone_number char(50) not null,
	salary decimal not null
);

create table invoice(
	invoice_number char(100) primary key not null,
	SN char(100) references car (SN) not null,
	sales_person_id int references sales_person (sales_person_id) not null,
	customer_id int references customer (customer_id) not null,
	invoice_date date not null,
	street_address char(50) not null,
	city char(100) not null,
	state char(100) not null,
	zip_code char(10) not null,
	billing_phone_number char(50) not null,
	billing_email_address char(50) not null
);

create table service_ticket(
	service_ticket_id int primary key not null,
	SN char(100) references car (SN) not null,
	customer_id int references customer (customer_id) not null,
	mechanic_id int references mechanic (mechanic_id) not null,
	repair_description char(500) not null,
	repair_cost decimal not null,
	repair_date date not null
);

insert into sales_person (sales_person_id, first_name, last_name, email, phone_number, salary)
values (1, 'John', 'Peterson', 'johnnyp@gmail.com', '1-234-567-8910', 60000);

insert into sales_person (sales_person_id, first_name, last_name, email, phone_number, salary)
values (2, 'Alex', 'Smith', 'asmith@yahoo.com', '1-432-765-1098', 80000);

insert into car (SN, model, color, car_year, make, price)
values ('1232435', 'x3', 'turquoise', 2019, 'Tesla', 120000);

insert into car (SN, model, color, car_year, make, price)
values ('876789', 'y3', 'beige', 2021, 'Bugatti', 50000000);

insert into mechanic (mechanic_id, first_name, last_name, email, phone_number, salary)
values (23, 'Hank', 'Jefferson', 'HankyJ@sbcglobal.net', '1-876-029-1002', 100000);

insert into mechanic (mechanic_id, first_name, last_name, email, phone_number, salary)
values (45, 'Matt', 'Kaine', 'KaineMatt@yahoo.com', '1-888-098-2734', 70000);

create or replace procedure add_customer(customer_id_in int, first_name_in char, last_name_in char, phone_number_in char, email_in char, street_address_in char, city_in char, state_in char, zip_code_in char) 
language plpgsql
as $$
begin
	insert into customer(customer_id, first_name, last_name, phone_number, email, street_address, city, state, zip_code)
	values (customer_id_in, first_name_in, last_name_in, phone_number_in, email_in, street_address_in, city_in, state_in, zip_code_in);
	commit;
end; $$;
call add_customer (10, 'Tim', 'Burton', '1-786-002-1010', 'timb@gmail.com', '5444 E Magnolia', 'Chesterton', 'Utah', '20302');
call add_customer (32, 'Josh', 'Richardson', '1-233-980-8766', 'Jrich@yahoo.com', '1234 N Addressway', 'Caterville', 'Alaska', '33245');
insert into invoice (invoice_number, SN, sales_person_id, customer_id, invoice_date, street_address, city, state, zip_code, billing_phone_number, billing_email_address)
values ('4100234', '1232435', 2, 10, '2022-04-23', 'N Hamshire Blvd', 'Chicago', 'Illinois', '12345', '1-000-220-0000', 'billingemail@sbcglobal.net');
insert into invoice (invoice_number, SN, sales_person_id, customer_id, invoice_date, street_address, city, state, zip_code, billing_phone_number, billing_email_address)
values ('7898789', '876789', 1, 32, '2017-02-12', '122 W Montgomery Way', 'Indianapolis', 'Indiana', '46038', '1-887-203-2000', 'mrguy@gmail.com');
insert into service_ticket (service_ticket_id, SN, customer_id, mechanic_id, repair_description, repair_cost, repair_date)
values (5, '1232435', 10, 45, 'bumper', 6000, '2022-10-04');
insert into service_ticket (service_ticket_id, SN, customer_id, mechanic_id, repair_description, repair_cost, repair_date)
values (4, '876789', 32, 23, 'tire change', 300, '2023-08-14');