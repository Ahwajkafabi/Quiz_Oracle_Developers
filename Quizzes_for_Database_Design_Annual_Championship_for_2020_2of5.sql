/*
Quiz on External Tables 5/5 (6)
Your Rating
Quiz
You create two files storing payment details and an external table that reads both of them:
*/

create or replace directory qz_tmp as '/tmp';
declare
  f utl_file.file_type;
begin
 
  f := utl_file.fopen ( 'QZ_TMP', 'qz_cash_payments.dat', 'w');
  utl_file.put_line ( f, '00001,2020-01-01,14.22');
  utl_file.put_line ( f, '00002,2020-01-02,14.03');
  utl_file.put_line ( f, 'Total,28.25');
  utl_file.fclose ( f );
 
  f := utl_file.fopen ( 'QZ_TMP', 'qz_card_payments.dat', 'w');
  utl_file.put_line ( f, '00003,2020-01-03,3.14,1111222233334444');
  utl_file.put_line ( f, '00004,2020-01-04,42.00,4242424242424242');
  utl_file.put_line ( f, 'Total,45.14');
  utl_file.fclose ( f );
end;
/

create table qz_payment_files (
  payment_reference varchar2(5),
  payment_date      date,
  amount            number,
  card_number       varchar(16)
) organization external (
  default directory qz_tmp
  access parameters (
    fields date_format date mask 'yyyy-mm-dd'
    missing field values are null
  )
  location (
    'qz_cash_payments.dat',
    'qz_card_payments.dat'
  )
) reject limit 1;

/*
Which choices contain a query that returns these rows?

PAYME PAYMENT_D     AMOUNT CARD_NUMBER
----- --------- ---------- ----------------
00001 01-JAN-20      14.22 <null>
00002 02-JAN-20      14.03 <null>
00003 03-JAN-20       3.14 1111222233334444
00004 04-JAN-20         42 4242424242424242
This assumes these SQL*Plus settings:

set null <null>

Choice 1
select * from qz_payment_files 
order  by payment_reference;

Choice 2
select * from qz_payment_files 
  external modify ( 
    reject limit unlimited 
  ) 
order  by payment_reference;

Choice 3
select * from ( 
  select * from qz_payment_files 
    external modify ( 
      location ( 
        'qz_cash_payments.dat' 
      ) 
    ) 
  union  all 
  select * from qz_payment_files 
    external modify ( 
      location ( 
        'qz_card_payments.dat' 
      ) 
    ) 
)     
order  by payment_reference;

Choice 4
select * from qz_payment_files 
  external modify ( 
    location ( 
      'qz_cash_payments.dat, qz_card_payments.dat' 
    ) 
    reject limit 3 
  ) 
order  by payment_reference;

Choice 5
select * from qz_payment_files 
  external modify ( 
    access parameters ( 
      records delimited by newline 
      load when ( payment_reference != 'Total' ) 
    ) 
  ) 
order  by payment_reference;

Choice 6
alter table qz_payment_files
  access parameters (
    records delimited by newline
    load when ( 1:5 ) != 'Total'
    fields date_format date mask 'yyyy-mm-dd'
    missing field values are null
  );
select * from qz_payment_files
order  by payment_reference;

Choice 7
alter table qz_payment_files
  access parameters
    using clob (
    select q'!
      records delimited by newline
      load when ( payment_reference != 'Total' )
      fields date_format date mask 'yyyy-mm-dd'
      missing field values are null!'
    from dual
  );
select * from qz_payment_files
order  by payment_reference;

Choice 8
select * from external (
(
  payment_reference varchar2(5),
  payment_date      date,
  amount            number,
  card_number       varchar(16)
)
  default directory qz_tmp
  access parameters (
    fields date_format date mask 'yyyy-mm-dd'
    missing field values are null
  )
  location ( 'qz_cash_payments.dat', 'qz_card_payments.dat' )
)
order  by payment_reference;

Choice 9
select * from external (
(
  payment_reference varchar2(5),
  payment_date      date,
  amount            number,
  card_number       varchar(16)
)
  default directory qz_tmp
  access parameters (
    records delimited by newline
    load when ( payment_reference!= 'Total' )
    fields date_format date mask 'yyyy-mm-dd'
    missing field values are null
  )
  location ( 'qz_cash_payments.dat', 'qz_card_payments.dat' )
)
order  by payment_reference;

Choice 10
select * from external (
(
  payment_reference varchar2(5),
  payment_date      date,
  amount            number,
  card_number       varchar(16)
)
  default directory qz_tmp
  access parameters (
    fields date_format date mask 'yyyy-mm-dd'
    missing field values are null
  )
  location ( 'qz_cash_payments.dat', 'qz_card_payments.dat' )
  reject limit 2
)
order  by payment_reference;

*/