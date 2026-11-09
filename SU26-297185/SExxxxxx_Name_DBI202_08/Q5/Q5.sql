use PE_DBI202_Su2026_B5;
go

SELECT 
    a.author_id,
    a.full_name,
    COUNT(l.loan_id) AS NumberOfLoans,
    COUNT(DISTINCT CASE WHEN l.loan_date >= '2025-10-01' AND l.loan_date <= '2025-12-31' THEN b.book_id END) AS NumberOfBooks,
    COUNT(DISTINCT CASE WHEN l.loan_date >= '2025-10-01' AND l.loan_date <= '2025-12-31' THEN l.member_id END) AS NumberOfMembers
FROM 
    Authors a
LEFT JOIN 
    Book_Authors ba ON a.author_id = ba.author_id
LEFT JOIN 
    Books b ON ba.book_id = b.book_id
LEFT JOIN 
    Loans l ON b.book_id = l.book_id 
    AND l.loan_date >= '2025-10-01' 
    AND l.loan_date <= '2025-12-31'
GROUP BY 
    a.author_id,
    a.full_name
ORDER BY 
    a.author_id ASC;