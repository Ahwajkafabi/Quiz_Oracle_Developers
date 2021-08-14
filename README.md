# Quiz_Oracle_Developers
Quiz (assume Oracle Database 18 1 or higher) ![Quiz (assume Oracle Database 18 1 or higher)](https://user-images.githubusercontent.com/69799720/129455022-e0bc6a14-fbe4-4754-8df8-07aed8da977c.png)
Choice 1
brick.shape := 'cylinder';
Choice 2
brick.brick_id := 1; 
brick.colour   := 'red'; 
brick.shape    := 'cylinder';
Choice 3
brick := brick_rec ( 
  brick_id =>  1, 
  colour   => 'red', 
  shape    => 'cylinder' 
);
Choice 4
select * 
into   brick 
from   qz_bricks 
where  brick_id = 1;

brick.shape := 'cylinder';
Choice 5
select * 
into   brick 
from   qz_bricks 
where  brick_id = 1;

brick := brick_rec ( 
  shape => 'cylinder' 
);
*/
