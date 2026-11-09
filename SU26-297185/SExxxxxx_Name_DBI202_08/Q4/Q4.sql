use PE_DBI202_Su2026_B5;
go

SELECT 
    c.category_id,
    c.category_name,
    sub.book_id,
    sub.title
FROM 
    Categories c
LEFT JOIN (
    SELECT DISTINCT 
        b.category_id,
        b.book_id,
        b.title
    FROM Books b
    JOIN Loans l ON b.book_id = l.book_id
    JOIN Members m ON l.member_id = m.member_id
    WHERE m.gender = 'Female'
      AND ((l.loan_date >= '2026-01-01' AND l.loan_date <= '2026-01-31') 
           OR (l.loan_date >= '2026-03-01' AND l.loan_date <= '2026-03-31'))
) sub ON c.category_id = sub.category_id
ORDER BY 
    c.category_name ASC,
    sub.title ASC;