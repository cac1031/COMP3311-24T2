/************
* Q12 - Q23 *
************/
-- check out supplier-schema.sql if you want some mock data

-- Q12
-- find supplier names who supply some red part
create or replace view Q12 as
select distinct s.sname
from Suppliers s
  join Catalog c on (s.sid = c.sid)
  join Parts p on (p.pid = c.pid)
where p.colour = 'red';

-- Q14
-- red part or address = '221 Packer Street'
create or replace view Q14 as
select distinct s.sid
from Suppliers s
  join Catalog c on (s.sid = c.sid)
  join Parts p on (p.pid = c.pid)
where p.colour = 'red' or s.address = '221 Packer Street';

-- Q16
-- Method 1
select c.sid
from Catalog c
group by c.sid
having count(*) = (select count(*) from Parts);

-- Method 2
select s.sid
from Suppliers s
where not exists(
  (select pid from Parts)
  except
  (select c.pid from Catalog c where c.sid = s.sid)
);

-- Q22
-- first find parts supplied by Yosemite Sham
create or replace view YosemiteSupplies as
select c.pid, c.cost
from Catalog c
  join Suppliers s on (s.sid = c.sid)
where s.sname = 'Yosemite Sham';

-- find the most expensive parts
select pid
from YosemiteSupplies
where cost = (select max(cost) from YosemiteSupplies);