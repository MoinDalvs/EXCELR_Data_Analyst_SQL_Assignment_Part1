# SET 1

## 1. create a database called 'assignment' (Note please do the assignment tasks in this database)
	
## 2. Create the tables from ConsolidatedTables.sql and enter the records as specified in it.

use assignment;

## 3. Create a table called countries with the following columns
-- name, population, capital  
-- choose appropriate datatypes for the columns

create table countries
   (
	name varchar(25) unique,
    population int,
    capital varchar(25)
    );

-- a) Insert the following data into the table

INSERT INTO countries (             name, population,           capital )
			   Values (          'China',	    1382, 	      'Beijing' ),
					  (          'India',		1326,	 	    'Delhi' ),
					  (  'United States',		 324, 'Washington D.C.' ),
					  (      'Indonesia',		 260,	 	  'Jakarta' ),
					  (         'Brazil',		 209,	 	 'Brasilia' ),
					  (       'Pakistan',		 193,	 	'Islamabad' ),
					  (        'Nigeria',		 187,	 	    'Abuja' ),
					  (     'Bangladesh',		 163,	 	    'Dhaka' ),
					  (         'Russia',	   	 143,	 	   'Moscow' ),
					  (         'Mexico',		 128,	  'Mexico City' ),
					  (          'Japan',		 126, 	        'Tokyo' ),
					  (    'Philippines',		 102,	 	   'Manila' ),
					  (       'Ethiopia',		 101,	  'Addis Ababa' ),
					  (        'Vietnam', 		  94,	 	    'Hanoi' ),
					  (          'Egypt',		  93,	 	    'Cairo' ),
					  (        'Germany',	      81,	 	   'Berlin' ),
					  (           'Iran',		  80,	 	   'Tehran' ),
					  (         'Turkey',		  79,	 	   'Ankara' ),
					  (          'Congo',		  79,	 	 'Kinshasa' ),
				      (         'France',		  64,	 	    'Paris' ),
					  ( 'United Kingdom',	      65,	 	   'London' ),
					  (          'Italy',		  60,	 	     'Rome' ),
					  (   'South Africa',		  55,	 	 'Pretoria' ),
					  (        'Myanmar',		  54,	 	'Naypyidaw' );

-- b) Add a couple of countries of your choice
					
INSERT INTO countries (          name, population,   capital )
			   Values ( 'South Korea',	       51, 	 'Seoul' ),
					  (    'Colombia',		   50,	'Bogota' ),
                      (       'Spain',		   46,	'Madrid' ),                      
					  (      'Uganda',		   45, 'Kampala' );

select *
	from countries;

-- c) Change ‘Delhi' to ‘New Delhi'

Update countries
	set capital = 'New Delhi'
		where name regexp 'India';

## 4. Rename the table countries to big_countries

Rename table countries to big_countries;

select *
	from big_countries;
    
## 5. Create the following tables. Use auto increment wherever applicable
-- a. Product
-- product_id - primary key
-- product_name - cannot be null and only unique values are allowed
-- description
-- supplier_id - foreign key of supplier table

create table product
	(
     product_id int primary key auto_increment,
     product_name varchar(30) unique not null,
     description varchar(500),
     supplier_id int
     );

alter table product
	auto_increment = 100;

create table suppliers
	(
     supplier_id int primary key auto_increment,
     supplier_name varchar(25),
     location varchar(30)
     );

alter table suppliers
	auto_increment = 1000;

create table stock
	(
     id int primary key auto_increment,
     product_id int,
     balance_stock int,
     foreign key(product_id)
		references product(product_id)
        on delete set null
	 );

Alter table stock
	auto_increment = 2000;

Alter table product
	add foreign key (supplier_id)
		references suppliers(supplier_id)
        on delete cascade;
        
## 6. Enter some records into the three tables.

INSERT INTO product ( product_name,                                                                                                                   description, supplier_id )
			 VALUES (     'Laptop',     'A laptop computer, sometimes called a notebook computer by manufacturers, is a battery- or AC-powered personal computer',        Null ),
                    (     'Mobile', 'A mobile phone, portable device for connecting to a telecommunications network in order to transmit and receive voice, etc.',        Null ),
                    (      'Watch',                                                 'A watch is a portable timepiece intended to be carried or worn by a person.',        Null ),
                    (  'Headphone',            'A Headphones are a pair of padded speakers which you wear over your ears in order to listen to a recorded music.',        Null );

INSERT INTO suppliers ( supplier_name,        location )
			   Values (          'HP', 'United States' ),
                      (     'Oneplus',         'China' ),
                      (          'MI',         'China' ),
                      (      'RealMe',         'China' );

Update product
	set supplier_id =
		case product_name
        when 'Laptop' then 1000
        when 'Mobile' then 1001
        when 'Watch' then 1002
        when 'Headphone' Then 1003
	END
		where product_name In ( 'Laptop', 'Mobile', 'Watch', 'Heaphone' );
        
Insert into stock ( product_id, balance_stock )
		   Values (        100,           205 ),
                  (        101,           156 ),
                  (        102,           567 ),
				  (        103,            45 );
                  
## 7. Modify the supplier table to make supplier name unique and not null.

Alter table suppliers
	modify supplier_name varchar(25) unique not null;
    
## 8. Modify the emp table as follows

-- a.	Add a column called deptno

 select *
	from emp;
    
alter table emp
	add column dept_no int
    after hire_date;

-- b. Set the value of deptno in the following order

-- deptno = 20 where emp_id is divisible by 2
-- deptno = 30 where emp_id is divisible by 3
-- deptno = 40 where emp_id is divisible by 4
-- deptno = 50 where emp_id is divisible by 5
-- deptno = 10 for the remaining records.

ALTER TABLE emp
	RENAME COLUMN emp_no to emp_id;

UPDATE emp
	SET dept_no = 
		case
        when emp_id % 2 = 0 THEN 20
        when emp_id % 3 = 0 THEN 30
        when emp_id % 4 = 0 THEN 40
		when emp_id % 5 = 0 THEN 50
        ELSE  10
	END;
   
# 9. Create a unique index on the emp_id column.

describe EMP_ID_UNIQemp;

CREATE UNIQUE INDEX EMP_ID_UNIQ
	ON emp ( emp_id );

# 10. Create a view called emp_sal on the emp table by selecting the following fields in the order of highest salary to the lowest salary.

-- emp_no, first_name, last_name, salary

ALTER TABLE emp
	RENAME COLUMN emp_id to emp_no;

CREATE VIEW emp_sal
as
select emp_no, 
       CONCAT( first_name, ' ', last_name) as Employee,
       salary
	from emp
		order by salary desc;
    
select *
	from emp_sal;