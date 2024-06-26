/* Schema:
Beers(name:string, brewer:string, style: string) <-- note this is correct version following the dump file, tut schema is incorrect
Bars(name:string, address:string, license#:integer)
Drinkers(name:string, address:string, phone:string)
Likes(drinker:string, beer:string)
Sells(bar:string, beer:string, price:real)
Frequents(drinker:string, bar:string)
*/

/** Q7 - Q11 **/
-- Q7
create or replace function hotelsIn(_addr text)
returns text
as $$
declare
  res text;
begin
  select string_agg(name, E'\n')
  into res
  from Bars
  where addr = _addr;
  return res;
end;
$$ language plpgsql;


-- Q8
create or replace function hotelsIn2(_addr text)
returns text
as $$
declare
  res text;
begin
  select string_agg(name, ' ')
  into res
  from Bars
  where addr = _addr;

  if (res is null) then
    return 'There are no hotels in ' || _addr;
  else
    return 'Hotels in ' || _addr || ': ' || res;
  end if;
  return res;
end;
$$ language plpgsql;


-- Q9
-- Note that the sample output that this function produces differs from the tut example as the database has slightly different values
create or replace function happyHourPrice(_hotel text, _beer text, _discount real)
returns text
as $$
declare
  _price real;
begin
  -- error checking
  perform *
  from Bars
  where name = _hotel;

  if (not found) then
    return 'There is no hotel called ''' || _hotel || '''';
  end if;

  perform *
  from Beers
  where name = _beer;

  if (not found) then
    return 'There is no beer called ''' || _beer || '''';
  end if;

  -- check if bar serves beer
  select price
  into _price
  from Sells
  where bar = _hotel and beer = _beer;

  if (_price is null) then  
    return _hotel || ' does not serve ' || _beer;
  end if;

  if (_price - _discount <= 0) then
    return 'Price reduction is too large; ' || _beer ' only costs ' || to_char(_price,'$9.99');
  else 
    return 'Happy hour price for ' || _beer || ' at ' || _hotel || ' is ' || to_char(_price - _discount,'$9.99');
  end if;
end;
$$ language plpgsql;


-- Q10
-- sql
create or replace function hotelsIn3(text) returns setof Bars
as $$
  select name, addr, license
  from Bars
  where addr = $1;
$$ language sql;

-- plpgsql
-- say instead, we want to return setof bars but in the license column
-- if the license number is below _record.addr we return 'Low license number'
drop type if exists BarInfo cascade;
create type BarInfo as (bname text, baddr text, blicense text);


create or replace function hotelsIn4(_addr text)
returns setof BarInfo
as $$
declare
  _record record;
  _return_tuple BarInfo;
begin
  for _record in
    select *
    from Bars
    where addr = _addr
  loop
    _return_tuple.bname := _record.name;
    _return_tuple.baddr := _record.addr;
    if (_record.license < 200000) then
      _return_tuple.blicense := 'Low License Number';
    else
      _return_tuple.blicense := _record.license::text;
    end if;
    return next _return_tuple;
  end loop;
end;
$$ language plpgsql;
