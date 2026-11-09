use PE_DBI202_Su2026_B5;
go

UPDATE Loans
SET return_date = GETDATE()
WHERE member_id = 5 
  AND return_date IS NULL;