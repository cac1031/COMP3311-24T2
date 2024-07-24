# COMP3311 - Week 9 Tutorial
```
Question Overview
• Functional Dependencies: Q1,12
• Closures: Q2
• Minimal Covers: Q13
• Back to FDs: Q6, Q5 (if you want more practice)
• Normal Forms: Q3,4 & 7
• 3NF Decomposition: Q17, Q16 (if you want more practice)
• BCNF Decomposition: Q15, Q14 (if you want more practice)
• FD Derivation + Decomposition (with actual schemas) : Q8,9,10,11
```

## Functional Dependencies
### Q1
**a. What functional dependencies are implied if we know that a set of attributes X is a candidate key for a relation R?**\
The entire relation R can be composed from X since it is the candidate key.

**b. What FDs do not hold?**
```
| A | B | C |
|---+---+---|
| a | 1 | x |
| b | 2 | y |
| c | 1 | z |
| d | 2 | x |
| a | 1 | y |
| b | 2 | z |
```
- B → C does not hold, because we have 1 → x and 1 → z. C → B also does not hold
- A → C does not hold, because we have a → x and a → y. C → A also does not hold
- AB → C does not hold, because we have a1 → x and a1 → y.
<br><br>
- On the flip side, BC → A is valid

**c.**
- E and F has a 1:1 relationship
- Every value of E maps to a unique value of F and vice versa.

## Closures
### Q2
Consider the relation R(A,B,C,D,E,F,G) and the set of functional dependencies F = { A → B, BC → F, BD → EG, AD → C, D → F, BEG → FA } compute the following:

**a. A+**\
A+ = {A, B}

**b. ACEG+**\
ACEG+ = {A, B, C, E, F, G}

**c. BD+**\
BD+ = {A, B, C, D, E, F, G}

## Minimal Covers
### Q13
**Compute a minimal cover for:**\
**F = { B → A, D → A, AB → D }**\
- Already in canonical form.

- Try making LHS single attribute
  - We have AB → D and B → A, therefore A can be reached from B. The A in AB → D is redundant
  - Fc = { B → A, D → A, B → D }

- Get rid of cycles/ transitive shortcuts
  - Fc = { D → A, B → D }

## Normal Forms
### Q3
R(A,B,C,D,E)\
F = { A → B, BC → E, ED → A }

**a. List all of the candidate keys for R.**\
CK: {ACD, CDE, BCD}

**b. In 3NF?**
- A → B -- B is a single attribute part of candidate key
- BC → E -- E is a single attribute part of candidate key
- ED → A -- A is a single attribute part of candidate key
- Yes, it is in 3NF.

**c. In BCNF?**
- A → B -- A is not a super key
- No, not in BCNF.

### Q4 + 7
Consider a relation R(A,B,C,D)
1. List out all candidate keys of R
2. Is it in 3NF?
3. Decompose to 3NF
4. Is it in BCNF?
5. Decompose to BCNF

**i] C → D, C → A, B → C**
### Part 1
Candidate Keys: {B}

### Part 2
- C → D: C is not a super key, C → D is not trivial, D is not part of a candidate key
- Not in 3NF.

### Part 3
- Put into minimal cover:
  - C → D, C → A, B → C
- Tables:
  - 3NF Set: {**C**D, **C**A, **B**C}

### Part 4
- C → D: C is not a super key, C → D is not trivial
- Not in BCNF.

### Part 5
- C → D violates BCNF. Decompose time.

Original Schema splits into:
- R1(CD), R2(ABC)
<br><br>

- R1(CD), CK: C, FD: C → D (in BCNF)
<br><br>

- R2(ABC), CK: B, FD: C → A, B → C
- C → A violates BCNF
<br><br>

- From R2:
- R3(CA), R4(BC)
- R3(CA), CK: C, FD: C → A (in BCNF)
<br><br>

- R4(BC), CK: B, FD: B → C (in BCNF)
<br><br>

- Therefore, we have that R1, R3, R4 in BCNF
- BCNF Set: {**C**D, **C**A, **B**C}

**ii] B → C, D → A**
### Part 1
Candidate Keys: {BD}

### Part 2
- B → C: B is not a super key, B → C is not trivial, C is not part of a candidate key
- Not in 3NF.

### Part 3
- Put into minimal cover
- F == Fc = {B → C, D → A}

- No table for Candidate Key, make one for it
- 3NF Set = {**B**C, **D**A, **BD**}

### Part 4
- B → C: B is not a super key, B → C is not trivial
- Not in BCNF.

### Part 5
- B → C not in BCNF. Decomposition time!
- Original Schema:
- R1(BC), R2(ABD)
<br><br>

- R1(BC), CK: B, FD: B → C (is BCNF)
<br><br>

- R2(ABD), CK: BD, FD: D → A
- D is not a super key, decompose again
<br><br>

- R2:
- R3(DA), R4(BD)
<br><br>

- R3(DA), CK: D, FD: D → A (is BCNF)
<br><br>

- R4(BD), CK: BD, FD: N/A (is BCNF)
<br><br>

- We have that R1, R3 and R4 are in BCNF.
- BCNF Set: {**B**C, **D**A, **BD**}

**iii] ABC → D, D -- A**
### Part 1
Candidate Keys: {ABC, BCD}

### Part 2
- ABC → D: ABC is a super key.
- D → A: A is a single attribute part of a candidate key.
- Yes, in 3NF.

### Part 3
- Already in 3NF.
- 3NF Set: {ABC.D, D.A}

### Part 4
- D → A: D is not a super key.
- Not in BCNF.

### Part 5
- D → A violates BCNF, so we decompose yeye.
- Original Schema:
- R1(DA), R2(BCD)
<br><br>

- R1(DA), CK: D, FD: D → A (in BCNF)
<br><br>

- R2(BCD), CK: BC, FD: BC → D (in BCNF)
<br><br>

- We have that R1 and R2 are in BCNF.
- BCNF Set: {**D**A, **BC**D}

**iv] A → B, BC -- D, A -- C**
### Part 1
Candidate Keys: {A}

### Part 2
- A → B: A is a super key
- BC → D: BC is not a super key, BC → D is not trivial, D is not part of a candidate key
- Not in 3NF.

### Part 3
- Put into minimal cover:
- FD: {A → B, BC → D, A → C}
- Fc: {A → BC, BC → D}
<br><br>

- 3NF Set: {**A**B, **A**C, **BC**D}

### Part 4
- BC → D: BC is not a super key, BC → D is not trivial
- Not in BCNF.

### Part 5
- BC → D violates BCNF. Decomposition time!
- Original Schema:
- R1(BCD), R2(ABC)
<br><br>

- R1(BCD), CK: BC, FD: BC → D (is BCNF)
<br><br>

- R2(ABC), CK: A, FD: A → B, A → C (is BCNF)
<br><br>

- We have that R1 and R2 is in BCNF
- BCNF Set: {**BC**D, **A**BC}

**v] AB → C, AB -- D, C -- A, D -- B**
### Part 1
Candidate Keys: {AB, CD, BC, AD}

### Part 2
- AB → C: AB is a super key
- AB → D: AB is a super key
- C → A: A is part of a candidate key
- D → B: B is part of a candidate key
- Yes, in 3NF.

### Part 3
- Already in 3NF.
- 3NF: {**AB**CD, **C**A, **D**B}

### Part 4
- C → A: C is not a super key
- Not in BCNF.

### Part 5
- C → A violates BCNF. Decompose time
- R1(CA), R2(BCD)
<br><br>

- R1(CA), CK: C, FD: C → A (is BCNF)
<br><br>

- R2(BCD), CK: {B, D}, FD: B → C, B → D, D → B (is BCNF)

- We have that R1, R2 in BCNF
- BCNF Set: {**C**A, **B**D, **B**C}

**vi] A → BCD**
### Part 1
Candidate Keys: {A}

### Part 2
- A → BCD: A is a super key
- Yes, in 3NF.

### Part 3
- Already in 3NF.
- 3NF: {**A**BCD}

### Part 4
- A → BCD: A is a super key
- Yes, in BCNF.

### Part 5
- Already in BCNF.
- BCNF: {**A**BCD}

## BCNF Decomposition
### Q15
**R = ABCDEFGH**\
**F = { ABH → C, A → DE, BGH → F, F → ADH, BH → GE }**
1. Compute the Candidate Key
ABH → C\
A → DE\
BGH → F\
F → ADH\
BH → GE

BF+ = {A, B, C, D, E, F, G, H}\
BH+ = {A, B, C, D, E, F, G, H}

2. Check each relation and do decomposition
ABH → C -- is BCNF\
A → DE -- is not BCNF\
BGH → F\
F → ADH\
BH → GE 

Split original Schema:
- R1(ADE), R2(ABCFGH)
<br><br>

- R1(ADE) ; CK: A ; FK: A → DE [BCNF]
- R2(ABCFGH) ; CK: BF+ = {A, B, C, F, G, H} ; FD: ABH → C, BGH → F, F → AH, BH → G
- R2(ABCFGH) ; CK: BH+ = {A, B, C, F, G, H}

ABH → C -- is BCNF\
BGH → F -- is BCNF\
F → AH -- is not BCNF\
BH → G

Split R2:
- R3(FAH), R4(BCFG)
<br><br>

- R3(FAH) ; CK: F ; FK: F → AH [BCNF]
<br><br>

- R4(BCFG) ; CK: BCEG ; FK: None. This is because all of the other FD (i.e. ABH → C, BGH → F, BH → G all have H on the LHS. Since H is not in this schema, there are no FDs left for R4) [BCNF]
<br><br>

- We have found that R1, R3 and R4 are in BCNF.
- BCNF Set: {**A**DE, **F**AH, **BCFG**}