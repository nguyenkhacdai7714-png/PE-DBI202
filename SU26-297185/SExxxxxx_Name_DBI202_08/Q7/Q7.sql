use PE_DBI202_Su2026_B5;
go 

WITH PublisherStats AS (
    SELECT 
        p.publisher_id,
        p.name AS publisher_name,
        p.country,
        COUNT(l.loan_id) AS TotalLoans,
        COUNT(DISTINCT l.book_id) AS DistinctBookBorrowed
    FROM 
        Publishers p
    LEFT JOIN 
        Books b ON p.publisher_id = b.publisher_id
    LEFT JOIN 
        Loans l ON b.book_id = l.book_id AND l.loan_date BETWEEN '2025-09-01' AND '2025-11-30'
    WHERE 
        p.country = 'USA'
    GROUP BY 
        p.publisher_id,
        p.name,
        p.country
),
RecentBooks AS (
    SELECT 
        p.publisher_id,
        b.title,
        RANK() OVER (PARTITION BY p.publisher_id ORDER BY l.loan_date DESC) AS rnk
    FROM 
        Publishers p
    JOIN 
        Books b ON p.publisher_id = b.publisher_id
    JOIN 
        Loans l ON b.book_id = l.book_id
    WHERE 
        p.country = 'USA'
        AND l.loan_date BETWEEN '2025-09-01' AND '2025-11-30'
)
SELECT 
    ps.publisher_id,
    ps.publisher_name,
    ps.country,
    ps.TotalLoans,
    ps.DistinctBookBorrowed,
    rb.title AS MostRecentBookTitle
FROM 
    PublisherStats ps
LEFT JOIN 
    RecentBooks rb ON ps.publisher_id = rb.publisher_id AND rb.rnk = 1
ORDER BY 
    ps.TotalLoans DESC,
    rb.title ASC;