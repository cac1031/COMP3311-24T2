create table Person(
  id integer primary key,
  name text,
  age integer check (age > 0)
);

create table FavouriteFood(
  p_id integer,
  food text,
  primary key (p_id, food)
);

insert into Person values
(1, 'Alice', 18),
(2, 'Bob', 42),
(3, 'Carol', 69),
(4, 'Foo', 10),
(7, 'Bar', 100);

insert into FavouriteFood values
(1, 'Chocolate'),
(2, 'Hamburger'),
(4, 'Cheese'),
(1, 'Ice Cream'),
(3, 'Chocolate'),
(6, 'Pasta');
