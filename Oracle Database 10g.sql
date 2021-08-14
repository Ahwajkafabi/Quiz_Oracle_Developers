/* You create qz_customers and qz_orders with some data. But then accidentally drop qz_orders! */

/* Question Luckily you have the recycle bin enabled, so you recover it with:
flashback table qz_orders to before drop;
You want to check what this restored.

Which of the following queries return at least one row? */

create table qz_customers (
  customer_id   integer not null primary key,
  customer_name varchar2(20) not null
);

create table qz_orders (
  order_id       integer not null 
    constraint qz_order_pk primary key,
  customer_id    integer not null 
    constraint qz_ord_customer_fk references qz_customers ( customer_id ),
  order_datetime date not null,
  constraint qz_ord_cust_date_u unique ( customer_id, order_datetime )
);

create index qz_ord_datetime_i on qz_orders ( order_datetime );

insert into qz_customers values (1, 'Big Customer');
insert into qz_orders values (1, 1, sysdate);
commit;

drop table qz_orders;

/* END-PRESETUP*/

/* Verification Script for Question 29627, played in Dynamite DB Design: 31 Mar - 6 Apr 2018 */

/* START-SETUP Code to create all objects used in quiz */


flashback table qz_orders to before drop;

/* Answare */

/* START-CHOICE 3 INCORRECT */
PROMPT Choice 3 INCORRECT

select constraint_name  
from   user_constraints 
where  table_name = 'QZ_ORDERS' 
/* foreign keys */
and    constraint_type = 'R';

/* END-CHOICE*/

/* START-CHOICE 5 CORRECT */
PROMPT Choice 5 CORRECT

select index_name  
from   user_indexes 
where  table_name = 'QZ_ORDERS';

/* END-CHOICE*/

/* Foreign keys to other tables are not restored in flashback table.*/


drop table qz_customers cascade constraints purge;
drop table qz_orders cascade constraints purge;

/*There were three indexes on the original table:

qz_ord_datetime_i
The primary key index
The unique constraint index
Flashback table recovers all indexes except domain and bitmap join indexes. So this returns three rows.*/
