INSERT INTO listings.manufacturers (company_name, addr)
VALUES ('Skechers', 'Some Address'), ('Asics', 'Some Address') RETURNING id;