-- Q2
/*
Part A
Teacher(staff#, semester, subject)
Subject(subjcode)

Part B
Teacher(staff#)
Teaches(semester, teacher, subject)
Subject(subjcode)

Part C
Teacher(staff#)
Subject(subjcode, semester, teacher)
*/

-- Q3
/*
== ER == 
P(id, a)
R(id, b)
S(id, c)
T(id, d)

== OO ==
P(id, a)
R(id, a, b)
S(id, a, c)
T(id, a, d)

== Single Table Method ==
P(id, a, b, c, d)

*/

-- Q4
/*
== ER == 
P(id, a)
R(id, b)
S(id, c)
T(id, d)

== OO ==
P(id, a)
R(id, a, b)
S(id, a, c)
T(id, a, d)

== Single Table Method ==
P(id, a, b, c, d, subclass)
*/

-- Q5
create table R(
  id serial primary key,
  name text,
  address varchar(50),
  d_o_b date check (value < now()),
);

create table S(
  name text,
  address varchar(50),
  d_o_b date check (value < now()),
  primary key (name, address)
);

-- Q12
-- Tables: Subject, Teaches, Lecturer, Faculty, School
create table Lecturer(
  lid serial primary key
);

create table Subjects(
  sid serial primary key
);

create table Teaches(
  lecturer_lid integer references Lecturer(lid),
  subjects_sid integer references Subjects(sid),
  primary key (lecturer_lid, subjects_sid)
);

create table Faculty(
  id serial primary key,
  dean integer references Lecturer(lid)
);

create table School(
  id serial primary key,
  member integer references Faculty(fid)
);

-- Q15
-- Tables: FavPlayer, Player, TeamColour, FanFavColour
create table Team(
  tname text primary key
);

create table TeamColour(
  team text references Team(tname),
  colour text,
  primary key (team, colour)
);

create table Fan(
  fname text primary key
);

create table FanFavColour(
  fan text references Fan(fname),
  colour text,
  primary key (fan, colour)
);

create table FavTeam(
  team text references Team(tname),
  fan text references Fan(fname),
  primary key (team, fan)
);

create table Player(
  pname text primary key,
  playsFor text references Team(tname)
);

-- this is correct
alter table Team
add captain text references Player(pname);

-- the statement below is wrong
alter table Team
add foreign key captain text references Player(pname);

-- why is it wrong?
/*
Because it is combining the column definition + constraint definition
Correct way if we want to use the key word of 'foreign key' would be

alter table Team
add column captain text,
add constraint fk_captain foreign key (captain) references Player(pname);
*/

create table FavPlayer(
  player text references Player(pname),
  fan text references Fan(fname),
  primary key (player, fan)
);
