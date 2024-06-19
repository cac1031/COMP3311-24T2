/***********
* Q1 - Q11 *
***********/
create table Employees (
  eid     integer,
  ename   text,
  age     integer,
  salary  real,
  primary key (eid)
);

create table Departments (
  did     integer,
  dname   text,
  budget  real,
  manager integer references Employees(eid),
  primary key (did)
);

create table WorksIn (
  eid     integer references Employees(eid),
  did     integer references Departments(did),
  percent real,
  primary key (eid,did)
);

-- Q2
update Employees
set salary = salary * 0.8
where age < 25;

-- Q3
update Employees
set salary = salary * 1.1
where eid in (
  select w.eid
  from WorksIn w
    join Departments d on (w.did = d.did)
  where d.dname = 'Sales'
);

-- Q5
create table Employees (
  eid     integer,
  ename   text,
  age     integer,
  salary  real check (salary >= 15000),
  primary key (eid)
);

-- Q6
create table WorksIn (
  eid     integer references Employees(eid),
  did     integer references Departments(did),
  percent real,
  primary key (eid,did),
  constraint FullTimeCheck
    check 1.0 >= (
      select sum(w.percent)
      from WorksIn w
      where w.eid = eid
    )
);

-- Q7
create table Departments (
  did     integer,
  dname   text,
  budget  real,
  manager integer references Employees(eid),
  primary key (did),
  constraint ManagerCheck
  check 1.0 = (
    select sum(percent)
    from WorksIn w
    where (w.eid = manager)
  )
);

-- Q8
-- Opt 1
create table WorksIn (
  eid     integer references Employees(eid) on delete cascade,
  did     integer references Departments(did),
  percent real,
  primary key (eid,did)
);

-- Opt 2
create table WorksIn (
  eid     integer references Employees(eid) on delete set null,
  did     integer references Departments(did),
  percent real,
  primary key (eid,did)
);

-- Opt 3
create table Employees (
  eid     integer default 0,
  ename   text,
  age     integer,
  salary  real,
  primary key (eid)
);

create table WorksIn (
  eid     integer references Employees(eid) on delete set default,
  did     integer references Departments(did),
  percent real,
  primary key (eid,did)
);


-- Q11
/*
  EID ENAME             AGE     SALARY
----- --------------- ----- ----------
    1 John Smith         26      25000
    2 Jane Doe           40      55000
    3 Jack Jones         55      35000
    4 Superman           35      90000
    5 Jim James          20      20000

  DID DNAME               BUDGET  MANAGER
----- --------------- ---------- --------
    1 Sales               500000        2
    3 Service             200000        4

  EID   DID  PCT_TIME
----- ----- ---------
    1     2      1.00
    2     1      1.00
    3     1      0.50
    3     3      0.50
    4     2      0.50
    4     3      0.50
    5     2      0.75
*/

-- Opt 1 (on delete cascade)
/*
  EID   DID  PCT_TIME
----- ----- ---------
    2     1      1.00
    3     1      0.50
    3     3      0.50
    4     3      0.50
*/

-- Opt 2 (on delete set null)
/*
  EID   DID  PCT_TIME
----- ----- ---------
    1     null      1.00
    2     1      1.00
    3     1      0.50
    3     3      0.50
    4     null      0.50
    4     3      0.50
    5     null      0.75
*/

-- Opt 2 (on delete set default, let's say default did = 0)
/*
  EID   DID  PCT_TIME
----- ----- ---------
    1     0      1.00
    2     1      1.00
    3     1      0.50
    3     3      0.50
    4     0      0.50
    4     3      0.50
    5     0      0.75
*/