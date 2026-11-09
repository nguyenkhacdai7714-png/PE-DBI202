use PE_DBI202_Su2026_B5;
go

CREATE PROCEDURE createLoan
    @member_id INT,
    @book_id INT,
    @loan_date DATE
AS
BEGIN
    -- Check 1: Member does not exist
    IF NOT EXISTS (SELECT 1 FROM Members WHERE member_id = @member_id)
    BEGIN
        RETURN 1;
    END

    -- Check 2: Book does not exist
    IF NOT EXISTS (SELECT 1 FROM Books WHERE book_id = @book_id)
    BEGIN
        RETURN 2;
    END

    -- Check 3: Member already has this book checked out with no return date
    IF EXISTS (SELECT 1 FROM Loans WHERE member_id = @member_id AND book_id = @book_id AND return_date IS NULL)
    BEGIN
        RETURN 3;
    END

    -- Check 4: All checks passed, insert new loan
    INSERT INTO Loans (book_id, member_id, loan_date, due_date, return_date)
    VALUES (@book_id, @member_id, @loan_date, DATEADD(day, 14, @loan_date), NULL);

    RETURN 0;
END;