create table car(
vin		SERIAL 			primary key,
make 	varchar(50),
model	varchar(50),
year	varchar(4),
color	varchar(100)
);

create table customer(
customer_id	SERIAL primary key,
first_name	varchar(50),
last_name	varchar(50),
vin 		integer,
foreign key (vin) references car(vin)
);

create table services( 
service_id	SERIAL primary key,
"desc" 		varchar(200),
bill_hours 	NUMERIC(2,2)
);

create table salesperson (
sales_id 	VARCHAR(50)		primary key,
first_name	VARCHAR(50),
last_name	VARCHAR(50)
);

create table title_invoice (
invoice_num	SERIAL		primary key,
vin			INTEGER,
sales_id	VARCHAR(50),
foreign key (sales_id) references salesperson(sales_id),
foreign key	(vin) references car(vin)
);

create table mechanic(
mech_id		VARCHAR(50)	primary key,
first_name	VARCHAR(50),
last_name	VARCHAR(50)
);

create table service_ticket( 
service_ticket_id	SERIAL			primary key,
car					INTEGER,
mechanic			VARCHAR(50),
foreign key (car) references car(vin),
foreign key (mechanic) references mechanic(mech_id)
);

create table parts(
part_num			SERIAL		primary key,
service_ticket		INTEGER,
foreign key (service_ticket) references service_ticket(service_ticket_id)
);

create table services_rendered(
service_ticket_id	INTEGER,
service_id			INTEGER,
foreign key (service_ticket_id) references service_ticket(service_ticket_id),
foreign key (service_id) references services(service_id)
);

create or replace function add_car(_vin INTEGER, _make VARCHAR, _model VARCHAR, _year VARCHAR, _color VARCHAR)
returns VOID
as $MAIN$
begin
	insert into car(vin, make, model, year, color)
	values (_vin, _make, _model, _year, _color)
end;
$MAIN$
language plpgsql;


create or replace function add_customer(_customer_id INTEGER, _first_name VARCHAR, _last_name VARCHAR, _vin INTEGER)
returns VOID
as $MAIN$
begin
	insert into customer(customer_id, first_name, last_name, vin)
	values (_customer_id, _first_name, _last_name, _vin )
end
$MAIN$
language plpgsql;

