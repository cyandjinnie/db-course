BEGIN;

CREATE ROLE listings_user;
CREATE ROLE clients_user;

CREATE USER auth_user WITH ENCRYPTED PASSWORD 'password';
CREATE USER search_user WITH ENCRYPTED PASSWORD 'password';
CREATE USER delivery_user WITH ENCRYPTED PASSWORD 'password';
CREATE USER catalogue_uploader WITH ENCRYPTED PASSWORD 'password';

GRANT SELECT, UPDATE ON clients.customers TO auth_user;

GRANT SELECT ON ALL TABLES IN SCHEMA listings TO search_user;

GRANT SELECT, UPDATE ON clients.orders TO delivery_user;
GRANT SELECT ON clients.customers TO delivery_user;

GRANT SELECT, UPDATE, INSERT ON listings.products, listings.offers TO catalogue_uploader;

COMMIT;