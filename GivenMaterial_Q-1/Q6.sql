SELECT
    E.Fname,
    E.Lname,
    E.Salary,
    D.Dname AS Dname
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
    ON E.Dno = D.Dnumber
WHERE E.Salary = (
    SELECT MAX(E2.Salary) FROM EMPLOYEE E2 WHERE E2.Dno = E.Dno
);
