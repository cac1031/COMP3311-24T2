/** Q14 - Q16 **/
-- Q14
create or replace function unitName(_ouid integer)
returns text
as $$
declare

begin
  
end;
$$ language plpgsql;


-- Q15
create or replace function unitID(partName text)
returns integer
as $$

$$ language sql;


-- Q16
create or replace function facultyOf(_ouid integer) returns integer
as $$
declare

begin

end;
$$ language plpgsql;

select o1.longname, o2.longname
from OrgUnit o1
  join UnitGroups u on (o1.id = u.owner)
  join OrgUnit o2 on (o2.id = u.member);