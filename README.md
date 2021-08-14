# Quiz_Oracle_Developers
Quiz (assume Oracle Database 18 1 or higher) ![Quiz (assume Oracle Database 18 1 or higher)](https://user-images.githubusercontent.com/69799720/129455022-e0bc6a14-fbe4-4754-8df8-07aed8da977c.png)
I Love Logic: 14 Aug - 20 Aug 2021 
![I Love Logic](https://user-images.githubusercontent.com/69799720/129455403-b3c10f89-63cb-44c6-89c2-940cb9a813f3.PNG)
Statement
1
create table plch_temperature (
   observation_date  date
 , degrees_celsius   number
)
Table created.
Statement
2
insert into plch_temperature values (date '2012-11-01', 10.1)
1 row(s) inserted.
Statement
3
insert into plch_temperature values (date '2012-11-02', 15.9)
1 row(s) inserted.
Statement
4
insert into plch_temperature values (date '2012-11-03',  5.2)
1 row(s) inserted.
Statement
5
insert into plch_temperature values (date '2012-11-04',  6.1)
1 row(s) inserted.
Statement
6
insert into plch_temperature values (date '2012-11-05',  7.6)
1 row(s) inserted.
Statement
7
insert into plch_temperature values (date '2012-11-06', 18.1)
1 row(s) inserted.
Statement
8
insert into plch_temperature values (date '2012-11-07', 24.0)
1 row(s) inserted.
Statement
9
insert into plch_temperature values (date '2012-11-08', -2.2)
1 row(s) inserted.
Statement
10
insert into plch_temperature values (date '2012-11-09',  0.0)
1 row(s) inserted.
Statement
11
insert into plch_temperature values (date '2012-11-10', 11.4)
1 row(s) inserted.
Statement
12
insert into plch_temperature values (date '2012-11-11', 10.0)
1 row(s) inserted.
Statement
13
insert into plch_temperature values (date '2012-11-12',  4.6)
1 row(s) inserted.
Statement
14
insert into plch_temperature values (date '2012-11-13',  6.0)
1 row(s) inserted.
Statement
15
insert into plch_temperature values (date '2012-11-14',  5.9)
1 row(s) inserted.
Statement
16
insert into plch_temperature values (date '2012-11-15', 18.1)
1 row(s) inserted.
Statement
17
insert into plch_temperature values (date '2012-11-16', 18.0)
1 row(s) inserted.
Statement
18
insert into plch_temperature values (date '2012-11-17', 35.4)
1 row(s) inserted.
Statement
19
insert into plch_temperature values (date '2012-11-18',  8.8)
1 row(s) inserted.
Statement
20
insert into plch_temperature values (date '2012-11-19', 25.4)
1 row(s) inserted.
Statement
21
insert into plch_temperature values (date '2012-11-20',  2.2)
1 row(s) inserted.
Statement
22
insert into plch_temperature values (date '2012-11-21', 10.5)
1 row(s) inserted.
Statement
23
insert into plch_temperature values (date '2012-11-22',  4.4)
1 row(s) inserted.
Statement
24
insert into plch_temperature values (date '2012-11-23', 19.2)
1 row(s) inserted.
Statement
25
insert into plch_temperature values (date '2012-11-24', 19.9)
1 row(s) inserted.
Statement
26
insert into plch_temperature values (date '2012-11-25',  1.1)
1 row(s) inserted.
Statement
27
insert into plch_temperature values (date '2012-11-26', 14.7)
1 row(s) inserted.
Statement
28
insert into plch_temperature values (date '2012-11-27',-15.1)
1 row(s) inserted.
Statement
29
insert into plch_temperature values (date '2012-11-28', 11.1)
1 row(s) inserted.
Statement
30
insert into plch_temperature values (date '2012-11-29', 17.4)
1 row(s) inserted.
Statement
31
insert into plch_temperature values (date '2012-11-30', 16.3)
1 row(s) inserted.
Statement
32
commit
Statement processed.
Statement
33
column degree_interval format a20
Unsupported Command
Statement
34
column num_days_graph  format a20
Unsupported Command
Statement
35
select case bucket
          when 0 then 'Degrees < 0'
          when 1 then '0 >= Degrees < 6'
          when 2 then '6 >= Degrees < 12'
          when 3 then '12 >= Degrees < 18'
          when 4 then '18 >= Degrees < 24'
          when 5 then 'Degrees >= 24'
                 else 'Unknown interval'
       end degree_interval
     , num_days
     , rpad('*',num_days,'*') num_days_graph
  from (
   select width_bucket(degrees_celsius,0,24,4) bucket
        , count(*) num_days
     from plch_temperature
    group by width_bucket(degrees_celsius,0,24,4)
       )
 order by bucket
DEGREE_INTERVAL	NUM_DAYS	NUM_DAYS_GRAPH
Degrees < 0	2	**
0 >= Degrees < 6	7	*******
6 >= Degrees < 12	9	*********
12 >= Degrees < 18	4	****
18 >= Degrees < 24	5	*****
Degrees >= 24	3	***

