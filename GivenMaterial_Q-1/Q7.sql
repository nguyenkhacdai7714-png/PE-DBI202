SELECT E.Ssn AS [Only Stafford not Houston] FROM EMPLOYEE E
WHERE EXISTS (
SELECT * FROM  WORKS_ON INNER JOIN PROJECT ON Pno = Pnumber
WHERE Essn =  Ssn AND  Plocation = 'Stafford')
AND NOT EXISTS (
SELECT * FROM  WORKS_ON INNER JOIN PROJECT ON Pno = Pnumber
WHERE Essn =  Ssn AND  Plocation = 'Houston')



