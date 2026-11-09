SELECT D.Dname AS department,
AVG(E.Salary) AS [average salary]	
FROM DEPARTMENT D
INNER JOIN EMPLOYEE E ON D.Dnumber= E.Dno
GROUP BY D.Dname