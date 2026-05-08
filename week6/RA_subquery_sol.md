# TCSS 445/545 Exercises on Relational Algebra of SQL and Subqueries

## Schema Reference
```
Supplier(sno, sname, scity, sstate)
Part(pno, pname, psize, pcolor)
Supply(sno, pno, qty, price)
Product(pid, name, price)
Purchase(pid, cid, store)
Customer(cid, name, city)
```

## Exercise 1: SQL to Logical Relational Algebra
Convert the following SQL query into a logical relational algebra expression.
```sql
SELECT DISTINCT x.name, z.name
FROM Product x, Purchase y, Customer z
WHERE x.pid = y.pid AND y.cid = z.cid AND x.price > 100 AND z.city = 'Seattle'
```

### Answer 1
```
Project[x.name, z.name](
  Select[x.price > 100 AND z.city = 'Seattle'](
    Product
    JOIN[x.pid = y.pid] Purchase
    JOIN[y.cid = z.cid] Customer
  )
)
```

## Exercise 2: Relational Algebra to SQL
Given the following relational algebra expression, write the equivalent SQL query.
```
Project[sname](
  Supplier
  JOIN[sno = sno] (
    Select[psize > 10](Part)
    JOIN[pno = pno] Supply
  )
)
```

### Answer 2
```sql
SELECT DISTINCT S.sname
FROM Supplier S, Part P, Supply Y
WHERE S.sno = Y.sno AND P.pno = Y.pno AND P.psize > 10
```

## Exercise 3: Subquery Unnesting
Rewrite the following correlated subquery into an unnested SQL query using the EXCEPT operator. This query finds all red parts that have never been supplied by a supplier located in Seattle.
```sql
SELECT P.pno
FROM Part P
WHERE P.pcolor = 'red'
AND NOT EXISTS (
  SELECT *
  FROM Supply Y, Supplier S
  WHERE Y.pno = P.pno AND Y.sno = S.sno AND S.scity = 'Seattle'
)
```

### Answer 3
```sql
SELECT pno
FROM Part
WHERE pcolor = 'red'
EXCEPT
SELECT Y.pno
FROM Supply Y, Supplier S
WHERE Y.sno = S.sno AND S.scity = 'Seattle'
```

## Exercise 4: Unnested SQL to RA Tree
Translate your unnested SQL answer from Exercise 3 into a complete relational algebra expression using the set difference operator.

### Answer 4
```
( Project[pno]( Select[pcolor = 'red'](Part) ) )
EXCEPT
( Project[pno]( Select[scity = 'Seattle'](Supplier) JOIN[sno = sno] Supply ) )
```