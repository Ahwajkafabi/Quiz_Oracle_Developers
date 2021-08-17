/*
Quiz on Materialized Views 5/5 (6)
Your Rating
Quiz
You create a table to store JSON data, a materialized view (MV) extracting the JSON data, insert documents to the table, and query the table:
*/
create table qz_brick_json (
  brick_id integer
    generated as identity
    not null
    primary key,
  json_data varchar2(1000)
    check ( json_data is json )
);

create materialized view qz_brick_json_mv
##REPLACE## ;

insert into qz_brick_json ( json_data )
  values ( '{ "colour":"red",   "shape":"cylinder", "weight":2 }' );
insert into qz_brick_json ( json_data )
  values ( '{ "colour":"blue",  "shape":"cube",     "weight":3 }' );
insert into qz_brick_json ( json_data )
  values ( '{ "colour":"green", "shape":"cone",     "weight":4 }' );

select count (*)
from   qz_brick_json_mv
where  colour = 'red';

/*
Which choices can go in the ##REPLACE## section to complete the MV definition, so when you run the query it returns this row?

  COUNT(*)
----------
         1
*/

/*

Choice 5
refresh fast on statement 
as 
select brick_id, 
       j.json_data.colour, 
       j.json_data.shape, 
       j.json_data.weight 
from   qz_brick_json j

Choice 7
refresh fast on statement
as
select brick_id,
       colour
from   qz_brick_json, json_table (
  json_data, '$'
  columns (
    colour varchar2(10) path '$.colour'
  )
)

Choice 10
refresh fast on statement
as
select brick_id,
       colour, shape, weight
from   qz_brick_json, json_table (
  json_data, '$'
  columns (
    colour varchar2(10) path '$.colour'
      error on error null on empty,
    shape  varchar2(10) path '$.shape'
      error on error null on empty,
    weight integer path '$.weight'
      error on error null on empty
  )
)

*/