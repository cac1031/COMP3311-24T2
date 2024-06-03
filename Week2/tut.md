# COMP3311 - Week 2 Tutorial
## Actionables
1. Quiz 1 due on Friday, 7 June at 11.59pm
2. Set up your Postgres Server


## Questions
- ER Warmup Ques: Q7, 6
- Relational Schema: Q17, 18
- Constructing an ER Diagram (Simple) - Q11
- Constructing an ER Diagram (Hard) - Q12, 13, 14, 15
- Extra ER Cardinality Prac [if time permits] - Q9


### Q7
**Draw an ER diagram for the following application from the manufacturing industry:**\
Done in class

### Q17
**Why are duplicate tuples not allowed in relations?**\
Not that it is not allowed, but tuples are always seen collectively as sets.

### Q18
**Consider the following simple relational schema:**
```
R(a1, a2, a3, a4)
S(b1, b2, b3)
```
**Which of the following tuples are not legal in this schema? Explain why the iillegal tuples are invalid.**\
(Assumed they are inserted into the db in order)
```
R(1, a, b, c) Yes
R(2, a, b, c) Yes
R(1, x, y, z) No
R(3, x, NULL, y) Yes
R(NULL, x, y, z) No
S(1, 2, x) Yes
S(1, NULL, y) No
S(2, 1, z) Yes
S(1, 1, y) Yes
```

### Q11
**Give an ER design for a database recording information about teams, players, and their fans, including:**\
Done in class
