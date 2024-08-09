WITH TrustedContacts AS (
    SELECT 
        c.customer_id,
        COUNT(DISTINCT co.contact_email) AS trusted_cnt
    FROM 
        Customers c
    INNER JOIN 
        Contacts co ON c.customer_id = co.user_id
    WHERE
        co.contact_email IN (SELECT DISTINCT email FROM Customers)
    GROUP BY 
        c.customer_id
)

SELECT 
    i.invoice_id, 
    c.customer_name, 
    i.price,
    COUNT(co.contact_email) AS contacts_cnt,
    ISNULL(tc.trusted_cnt, 0) AS trusted_cnt
FROM 
    Customers c
LEFT JOIN 
    Contacts co ON c.customer_id = co.user_id
LEFT JOIN 
    Invoices i ON i.user_id = c.customer_id
LEFT JOIN 
    TrustedContacts tc ON tc.customer_id = c.customer_id
GROUP BY 
    i.invoice_id, c.customer_name, i.price, tc.trusted_cnt;
