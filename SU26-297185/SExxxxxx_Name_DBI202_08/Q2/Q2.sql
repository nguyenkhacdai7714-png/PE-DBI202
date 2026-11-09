use PE_DBI202_Su2026_B5;
go

SELECT 
    book_id, 
    title, 
    isbn, 
    published_year, 
    category_id, 
    publisher_id, 
    total_copies
FROM 
    Books
WHERE 
    published_year BETWEEN 1800 AND 1899
    AND title LIKE 'The %';