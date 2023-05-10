SELECT
    *
FROM
    listings.products p
LEFT JOIN
    listings.offers o
ON
    o.product_id = p.id

SELECT
    *
FROM
    listings.products p
INNER JOIN
    listings.offers o
ON
    o.product_id = p.id