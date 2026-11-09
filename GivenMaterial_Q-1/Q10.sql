UPDATE EMPLOYEE
SET Salary = Salary  + (Salary * 10 / 100)
WHERE EXISTS (
    SELECT *
    FROM DEPENDENT D
    WHERE D.Essn = EMPLOYEE.Ssn
      AND D.Bdate > DATEADD(YEAR, -18, GETDATE())
      AND D.Bdate <= GETDATE()
);


