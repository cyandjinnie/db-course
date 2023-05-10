UPDATE listings.manufacturers m
SET addr = s.addr
FROM listings.sellers s
WHERE s.company_name = m.company_name