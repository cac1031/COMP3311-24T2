/*
COMP3311 - Wk7 Tut (Assertions, Triggers, Aggregates)

Admin:
• Quiz 4 due on Friday 27 October @ 11.59pm

Question Distribution:
• Q1-2 – Assertions
• Q3-5 – Triggers Theory
• Q6-8 – More Triggers
• Q9-12 – Triggers with Concrete Databases (9, 11)
• Q13-15 – Aggregates
*/
--------------------------------------
-- 1,2 → 13,14 → 3,4,5 → 6,7 → 9,11 --
--------------------------------------

-- [ASSERTIONS] --
-- Consider a schema for an organisation
---------------------------------------------------------------------------
Employee(id:integer, name:text, works_in:integer, salary:integer, ...) 
Department(id:integer, name:text, manager:integer, ...)
---------------------------------------------------------------------------
-- Q1. Ensure manager must work in the Department they manage
create or replace assertion manager_works_in_department
check (
  not exists (
    select *
    from Employee e
      join Department d on (e.id = d.manager)
    where e.works_in != d.id
  )
);

-- Q2. Ensure no employee in a department earns more than their manager
create or replace assertion employee_manager_salary
check (
  not exists (
    select *
    from Employee e
      join Department d on (e.works_in = d.id)
      join Employee m on (m.id = d.manager)
    where e.salary > m.salary
  )
);

-- [AGGREGATES] --
-- Q14. avg aggregate

-- stype --> state type
create type SumCount(sum numeric, count integer);

-- sfunc --> state function
create or replace function myAvgFunc(state SumCount, n numeric)
returns SumCount as $$
begin
  if (n is null) then
    return state;
  else
    state.count := state.count + 1;
    state.sum := state.sum + n;
    return state;
  end if;
end;
$$ language plpgsql;

-- finalfunc --> final function
create or replace function myFinalAvgFunc(fstate SumCount)
returns numeric as $$
begin
  if (fstate.count = 0) then
    return 0;
  else
    return fstate.sum / fstate.count;
  end if;
end;
$$ language plpgsql;

-- the aggregate
create or replace aggregate avg(numeric) (
  sfunc = myAvgFunc,
  stype = SumCount,
  initcond = '(0,0)',
  finalfunc = myFinalAvgFunc
);

-- [TRIGGERS] --
-- Q6a
create or replace function R_pk_check() returns trigger
as $$
begin
  -- check not null
  if (new.a is null or new.b is null) then
    raise exception 'Primary keys cannot be null';
  end if;

  -- check uniqueness
  if (TG_OP = 'UPDATE' and old.a = new.a and old.b = new.b) then
    return new;
  end if;

  perform *
  from R
  where new.a = a and new.b = b;

  if (found) then
    raise exception '% and % already exists as primary keys', new.a, new.b;
  end if;

  return new;
end;
$$ language plpgsql;

create or replace trigger R_pk_trigger
before insert or update
on Table R
for each row
execute procedure R_pk_check();

-- Q6b
-- Table T (foreign key) --
create or replace function T_fk_check() returns trigger
as $$
begin
  -- check valid reference
  perform *
  from S
  where x = new.k;

  if (not found) then
    raise exception 'Invalid reference to table S';
  end if;

  return new;
end;
$$ language plpgsql;

create or replace trigger T_fk_trigger
before insert or update
on T
for each row
execute procedure T_fk_check();

--------------------------------------------------------------------

-- Table S (parent) --
create or replace function S_ref_check() returns trigger
as $$
begin
  -- making sure there are no references to it
  -- assume we don't implement 'ON DELETE CASCASE'
  if (TG_OP = 'UPDATE' and old.x = new.x) then
    return new;
  end if;

  perform *
  from T
  where k = old.x;

  if (found) then
    raise exception 'There are references to % in the T table', old.x;
  end if;

  return new;
end;
$$ language plpgsql;

create or replace trigger S_ref_trigger
before update or delete
on S
for each row
execute procedure S_ref_check();

-- Q9
create or replace function emp_check() returns trigger
as $$
begin
  -- check name and salary
  if (new.empname is null) then
    raise exception 'Employee name cannot be null';
    return null;
  end if;

  if (new.salary < 0) then
    raise exception 'Salary cannot be null';
  end if;

  -- stamp time and user
  new.last_date := now();
  new.last_user := user();
  return new;
end;
$$ language plpgsql;

create or replace trigger emp_trigger
before update or insert
on Emp
for each row
execute procedure emp_check();
