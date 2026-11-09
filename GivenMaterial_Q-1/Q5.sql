SELECT Dname AS Dname FROM DEPARTMENT
WHERE EXISTS (
SELECT * FROM PROJECT 
WHERE Dnum = Dnumber AND Plocation = 'Houston')
AND NOT EXISTS (
SELECT * FROM PROJECT 
WHERE Dnum = Dnumber AND Plocation = 'HCM')








