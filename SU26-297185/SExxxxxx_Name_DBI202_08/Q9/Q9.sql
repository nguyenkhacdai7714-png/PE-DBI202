use PE_DBI202_Su2026_B5;
go

CREATE TRIGGER Tr1
ON Loans
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert only rows where the current active loans + cumulative rank within the batch 
    -- does not exceed the total copies allowed for the book.
    INSERT INTO Loans (book_id, member_id, loan_date, due_date, return_date)
    SELECT i.book_id, i.member_id, i.loan_date, i.due_date, i.return_date
    FROM (
        SELECT 
            book_id, 
            member_id, 
            loan_date, 
            due_date, 
            return_date,
            ROW_NUMBER() OVER (PARTITION BY book_id ORDER BY (SELECT NULL)) AS rn
        FROM inserted
    ) i
    JOIN Books b ON i.book_id = b.book_id
    OUTER APPLY (
        SELECT COUNT(*) AS active_loans
        FROM Loans l
        WHERE l.book_id = i.book_id AND l.return_date IS NULL
    ) existing
    WHERE existing.active_loans + i.rn <= b.total_copies;
END;