use PE_DBI202_Su2026_B5;
go

SELECT DISTINCT 
    b.book_id, 
    b.title, 
    b.isbn, 
    b.published_year
FROM 
    Books b
JOIN 
    Book_Authors ba ON b.book_id = ba.book_id
JOIN 
    Authors a ON ba.author_id = a.author_id
WHERE 
    b.published_year > 1990
    AND a.gender = 'Male';