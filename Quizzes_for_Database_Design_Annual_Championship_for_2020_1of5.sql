/*
Quiz on Partitioning 5/5 (6)
Your Rating
Quiz
You create this partitioned table:
*/

create table qz_orders (
  order_id integer
    not null 
    constraint qz_orders_pk primary key,
  order_datetime date
    not null,
  customer_id integer
    not null
) partition by range ( order_datetime )
  interval ( interval '1' month ) (
  partition p0 values less than ( date'2021-01-01' )
);

/*
Which choices change the table, so it has one partition and four subpartitions?

After a correct choice, this query should return the row shown:

select partition_name, count(*)
from   user_tab_subpartitions
where  table_name = 'QZ_ORDERS'
group  by partition_name;

PARTITION_NAME         COUNT(*)
-------------------- ----------
P0                            4

Choice 1
alter table qz_orders 
  modify partition by range ( order_datetime ) 
  subpartition by hash ( customer_id ) 
  subpartitions 4 ( 
    partition p0 values less than ( date'2021-01-01' ) 
  );

Choice 2
alter table qz_orders 
  modify partition by range ( order_datetime ) 
  interval ( numtoyminterval ( 1, 'month' ) ) 
  subpartition by hash ( customer_id ) 
  subpartitions 4 ( 
    partition p0 values less than ( date'2021-01-01' ) 
  );

Choice 3
alter table qz_orders 
  modify partition by range ( order_datetime ) 
  interval ( interval '1' month ) 
  subpartition by hash ( customer_id ) 
  subpartition template ( 
    subpartition subp1, subpartition subp2, 
    subpartition subp3, subpartition subp4 
  ) ( 
    partition p0 values less than ( date'2021-01-01' ) 
  );

Choice 4
alter table qz_orders 
  modify partition by hash ( customer_id ) 
  subpartition by range ( order_datetime ) 
  subpartition template ( 
    subpartition p0 values less than ( date'2021-01-01' ) 
  ) 
  partitions 4;

Choice 5
alter table qz_orders 
  modify partition by hash ( customer_id ) 
  subpartition by range ( order_datetime ) 
  interval ( interval '1' month ) 
  subpartition template ( 
    subpartition p0 values less than ( date'2021-01-01' ) 
  ) 
  partitions 4;

Choice 6
alter table qz_orders
  modify partition by range ( order_datetime )
  interval ( interval '1' month )
  subpartition by hash ( customer_id )
  subpartitions 4 (
    partition p0 values less than ( date'2021-01-01' )
  )
  online;

Choice 7
alter table qz_orders
  modify partition p0
  add subpartition subp1, subpartition subp2,
      subpartition subp3, subpartition subp4;

Choice 8
alter table qz_orders
  modify partition by range ( order_datetime )
  interval ( interval '1' month )
  subpartition by hash ( customer_id )
  subpartitions 4 (
    partition p0 values less than ( date'2021-01-01' )
  )
  update indexes (
    qz_orders_pk global
      partition by hash ( customer_id )
      partitions 4
  );

Choice 9
alter table qz_orders
  modify partition by range ( order_datetime )
  interval ( interval '1' month )
  subpartition by hash ( customer_id )
  subpartitions 4 (
    partition p0 values less than ( date'2021-01-01' )
  )
  update indexes (
    qz_orders_pk local
  );

Choice 10
alter table qz_orders
  modify partition by range ( order_datetime )
  interval ( interval '1' month )
  subpartition by hash ( customer_id )
  subpartitions 4 (
    partition p0 values less than ( date'2021-01-01' )
  )
  update indexes (
    qz_orders_pk global
      partition by hash ( order_id )
      partitions 4
  );

*/