use PE_DBI202_Su2026_B5;
go 

SELECT 
    m.member_id,
    m.full_name
FROM 
    Members m
JOIN 
    Loans l ON m.member_id = l.member_id
JOIN 
    Books b ON l.book_id = b.book_id
GROUP BY 
    m.member_id,
    m.full_name
HAVING 
    COUNT(DISTINCT b.category_id) = 1
ORDER BY 
    m.full_name ASC;