-- create colour type
-- gonna make the supplier and part id a serial
drop type if exists colour;
create type colour as enum ('red', 'green', 'blue', 'black');

drop type if exists part;
create type part as enum ('screw', 'hook', 'bolt', 'nut', 'nail');

drop table if exists Suppliers;
create table Suppliers (
  sid     serial primary key,
  sname   text not null,
  address text
);

drop table if exists Parts;
create table Parts (
  pid     serial primary key,
  pname   text,
  colour  colour not null
);

drop table if exists Catalog;
create table Catalog (
  sid     integer references Suppliers(sid),
  pid     integer references Parts(pid),
  cost    real check (cost > 0.0),
  primary key (sid, pid)
);

insert into Suppliers(sname, address) values
('Acme Corp', '456 Industrial Road'),
('Global Supply', '789 Market St'),
('Prime Wholesale', null),
('QuickMart', '202 South St'),
('Best Goods', '303 East Ave'),
('Quality Supplies', null),
('Efficient Supplies', null),
('Trusted Goods', '777 Chestnut St'),
('Packer Goods', '221 Packer Street'),
('Trade Partners', '444 Magnolia St'),
('Alliance Supply', '333 Olive St'),
('Pioneer Goods', '222 Redwood St'),
('Yosemite Sham', '123 Forest Trail'),
('Pro Wholesale', null),
('Pro Wholesale', '91 Rainbow Ln');

insert into Parts(pname, colour) values
('screw', 'red'),
('screw', 'green'),
('screw', 'blue'),
('screw', 'black'),
('hook', 'blue'),
('hook', 'green'),
('bolt', 'red'),
('bolt', 'blue'),
('nut', 'green'),
('nut', 'black'),
('nut', 'blue'),
('nail', 'red'),
('nail', 'green'),
('nail', 'black'),
('screw', 'red');

insert into Catalog values
(1, 1, 12.99),
(2, 2, 15.49),
(3, 3, 120.99),
(4, 4, 111.79),
(5, 5, 14.29),
(6, 6, 180.89),
(7, 7, 10.69),
(8, 8, 213.09),
(9, 9, 50.59),
(10, 10, 124.49),
(11, 11, 211.59),
(12, 12, 115.19),
(13, 13, 119.79),
(14, 14, 12.89),
(15, 15, 107.39),
(1, 2, 114.29),
(2, 3, 22.49),
(3, 4, 112.69),
(4, 5, 14.09),
(5, 6, 217.59),
(6, 7, 11.59),
(7, 8, 15.19),
(8, 9, 19.79),
(9, 10, 12.89),
(10, 11, 417.39),
(11, 12, 13.99),
(12, 13, 116.49),
(13, 14, 24.99),
(14, 15, 311.79),
(15, 1, 14.29),
(1, 3, 18.89),
(2, 4, 311.69),
(3, 5, 314.19),
(4, 6, 17.69),
(5, 7, 410.49),
(6, 8, 12.99),
(7, 9, 16.59),
(8, 10, 223.29),
(9, 11, 12.79),
(10, 12, 17.29),
(11, 13, 19.79),
(12, 14, 312.89),
(13, 15, 117.39),
(14, 1, 12.99),
(15, 2, 115.49),
(5, 1, 10.29),
(5, 2, 13.45),
(5, 3, 300.56),
(5, 4, 120.49),
(5, 8, 100.32),
(5, 9, 64.22),
(5, 10, 21.45),
(5, 11, 90.98),
(5, 12, 10.29),
(5, 13, 56.75),
(5, 14, 344.98),
(5, 15, 234.11),
(15, 7, 31.46),
(4, 2, 50.81),
(4, 9, 300.11),
(4, 13, 92.12),
(15, 12, 215.39);
