---------------------------------
-- COMP3311 (Week 5) Functions --
---------------------------------

/* Function Syntax (SQL) */
-- no return statement needed
-- all query results from selct statement are returned
create or replace function FuncName(argtype1, argtype2,...)
returns rettype
as $$

$$ language sql;


/* Function Syntax (plpgsql) */
create or replace function FuncName(argname1 argtype1, argname2 argtype2, ...)
returns rettype
as $$
declare -- where local variables are declared/ defined (use :=)
    _foo boolean;
    _bar real := 1.0;
begin
    -- if statements
    if cond then
      do_stuff;
    elsif cond then
      do_stuff;
    else
      do_stuff;
    end if;

    -- while loops
    while cond loop
      do_stuff
    end loop;

    -- for loops
    for i in lo..hi loop
      do_stuff
    end loop;

    -- case statements
    select case
    when cond1 then statement1
    when cond2 then statement2
    when cond3 then statement3
    else statementelse
    end
    ... continue_with_query_here ...
end;
$$ language plpgsql;

/* Data Precedence in SQL: https://learn.microsoft.com/en-us/sql/t-sql/data-types/data-type-precedence-transact-sql?view=sql-server-ver16 */

/* Returning Tuples (plpgsql) */
create or replace function FuncName(argname1 argtype1, argname2 argtype2, ...)
returns setof rettype
as $$
begin
  some loop
    return next thing; -- we use 'return this' to build up our result set.
    -- Note that we don't return immediately. SQL appends rows to the function and returns everything in the end
  end loop;
end;
$$ language plpgsql;

-- Another example
drop type if exists Student cascade;
create type Student as (zid integer, degree text);

create or replace function FuncName(argname1 argtype1, argname2 argtype2, ...)
returns setof Bars
as $$
declare
  r record; -- generic type
begin
  SQL_query_here
  if (not found) then
    raise exception 'exception msg';
  end if;

  for r in 
    -- query
    select ... 
    from TableName
    where cond
  
  loop
    return next r; 
  end loop;
end;
$$ language plpgsql;

-- Distribution of Content --
/*
• Q1-6   : Simple Functions --> Q1,2,3
• Q7-11  : Beer/Bars/Drinkers Database
• Q12-13 : Bank Database
• Q14-16 : UNSW Database
*/
