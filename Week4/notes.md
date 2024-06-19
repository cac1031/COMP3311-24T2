# COMP3311 - Week 4 Tut

## Admin
1. Quiz 3 due on Friday (21 June) on 11.59pm Sydney time
2. Week 3 Tut + Quiz 2 Answers should have been released
3. Assignment 1 has been released

## Tut Questions
- Q1-11: focus on creating/adding/removing from database
- Q12-24: querying a database

## More SQL Syntax
```sql
insert into TableName(attr)
values (Tuple)

delete from TableName
where condition

update TableName
set attrChange
where condition
```

## Basic SQL Query Syntax
``` sql
select <column(s)>
from TableName
where condition
group by groupingAttributes
having groupCondition;
```

## SQL Joins
Person Table
| ID | Name | Age |
|----|------|-----|
| 1  | Alice|  18 |
| 2  | Bob  |  42 |
| 3  | Carol|  69 |
| 4  | Foo  |  10 |
| 7  | Bar  | 100 |

Favourite Food Table
| P_ID | FavouriteFood |
|------|---------------|
|   1  |   Chocolate   |
|   2  |   Hamburger   |
|   4  |    Cheese     |
|   1  |   Ice Cream   |
|   3  |   Chocolate   |
|   6  |     Pasta     |

`suppose we want to join on the ID attribute`
- Inner Join (default)
- Left Join
- Right Join
- Full Join/Full Outer Join

## Division
- Find values in one table that related to **EVERY** value in another table