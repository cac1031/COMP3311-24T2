# COMP3311 - Week 2 Tutorial

## Setting Up PostgreSQL Server

### Full Guide is in [Prac Exercise 1](https://cgi.cse.unsw.edu.au/~cs3311/24T2/pracs/01/index.php)

### Getting started with vsdb2
- From VLab: `ssh YourZid@nw-syd-vxdb2`
  - `cd /localstorage/$USER` ← navigate to your directory
- From VSCode (ssh): `ssh YourZID@d2.cse.unsw.edu.au` OR make a new client to connect to d2 locally
  - host is `d2.cse.unsw.edu.au`

### Connecting to the server
1. When in vxdb2, type `3311 pginit` ← you only need to do this for the first time
2. Type `source /localstorage/$USER/env` 
3. Type `p1` ← This starts your Postgres server
4. `psql <dbname>` ← Enter the terminal interface to interact with your db
5. p0 ← Kill your server. Please do this everytime before you log out

### Useful psql commands
1. `psql -l` ← list the current databases
2. `psql <db> -f <file>` ← load data into your database from a file
3. `help` ← quick list of useful meta commands
4. `dt` ← list all tables in the current schema
5. `df` ← list all user defined functions
6. `dv` ← list all views in the current schema
7. `d <TableName>` ← list all attributes in the specified table and info about each attributes
8. `\i <file>` ← load all current changes from an SQL file. Similar to the second command above, except I don't have to exit the database

## Content Recap
**What is data modelling?**
- design process
- visual representation of data objects and their relationships to one another

**ER Model**
- entities
  - weak entities
- attributes
  - composite, derived, multivalued
- relationships
- primary key & foreign keys
- disjoint/overlapping relationships
- cardinality

**Relational Model**
- foreign key has arrow towards primary key
- Relational Schema = how different tables relate to each other
- Relation = table itself
- Tuple = entry in a relation

**ER to Relational**
1. 1:1 → relationship goes on either side. Favour side with total participation
2. 1:n → relationship goes to the '1' side
3. n:m → relationship is its own relation (table)
4. Subclass Mapping
  - ER Style
  - OO Style
  - Single Version
