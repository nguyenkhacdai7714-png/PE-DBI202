SELECT
    s.staff_id,
    s.first_name,
    s.last_name,
    s.email,
    s.manager_id,
    st.store_id,
    st.store_name
FROM staffs s
INNER JOIN stores st ON s.store_id = st.store_id
WHERE NOT EXISTS (
    SELECT * FROM orders o
    WHERE o.staff_id = s.staff_id
);


