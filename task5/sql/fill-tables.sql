BEGIN;

INSERT INTO listings.manufacturers (id, company_name, addr)
VALUES (0, 'Nike', 'Some Address'), (1, 'Adidas', 'Some Address'), (2, 'New Balance', 'Some Address');

INSERT INTO listings.categories (id, category_name)
VALUES (0, 'shoes'), (1, 'boots');

INSERT INTO listings.sellers (id, company_name, addr)
VALUES (0, 'Official Nike', 'Some Address'), (1, 'Bootleg Adidas', 'Some Address');

INSERT INTO listings.products (id, product_name, description, manufacturer_id, category_id)
VALUES (0, 'Nike AirMax', 'Cool shoes', 0, 0), (1, 'Adidas Yeezy', 'Cool shoes', 1, 0), (2, 'New Balance 574', 'Cool shoes', 1, 0);

INSERT INTO listings.offers (id, product_id, seller_id, price, quantity, offer_start_date, offer_end_date)
VALUES (0, 0, 0, 100.0, 100, NOW(), DATE '2030-10-30'), (1, 1, 1, 99.9, 200, NOW(), DATE '2031-10-30');

INSERT INTO clients.customers (id, username, pass_hash, full_name, addr, email)
VALUES (0, 'eager1', 'dwadbwh', 'Igor Maksimov', 'No address sorry', 'igormaximow@gmail.com');

INSERT INTO clients.orders (customer_id, order_date, offer_id, quantity)
VALUES (0, NOW(), 0, 1);

COMMIT;