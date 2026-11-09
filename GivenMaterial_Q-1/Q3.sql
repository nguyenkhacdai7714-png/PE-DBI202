SELECT
D.Dname AS [Department name],
COUNT (E.Ssn) AS [Number of employees]
FROM DEPARTMENT D
INNER JOIN EMPLOYEE E ON D.Dnumber = E.Dno
GROUP BY D.Dnumber, D.Dname
HAVING COUNT(E.Ssn) > 3
ORDER BY COUNT(E.Ssn) DESC;