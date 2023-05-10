BEGIN;
CREATE SCHEMA listings AUTHORIZATION "user"
CREATE TABLE manufacturers (
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(50) UNIQUE NOT NULL,
    addr TEXT NOT NULL
)
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE NOT NULL
)
CREATE TABLE sellers (
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(50) UNIQUE NOT NULL,
    addr TEXT NOT NULL
)
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name TEXT NOT NULL,
    description TEXT NOT NULL,
    manufacturer_id INT NOT NULL,
    category_id INT NOT NULL,
    CONSTRAINT manufacturer_fk FOREIGN KEY (manufacturer_id) REFERENCES manufacturers(id),
    CONSTRAINT category_fk FOREIGN KEY (category_id) REFERENCES categories(id)
)
CREATE TABLE offers (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    seller_id INT NOT NULL,
    price FLOAT NOT NULL,
    quantity INT NOT NULL,
    offer_start_date DATE NOT NULL,
    offer_end_date DATE NOT NULL,
    CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT seller_fk FOREIGN KEY (seller_id) REFERENCES sellers(id)
);

CREATE INDEX offer_start_date_ix ON listings.offers (offer_start_date);
CREATE INDEX offer_end_date_ix ON listings.offers (offer_end_date);

CREATE SCHEMA clients AUTHORIZATION "user"
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255),
    pass_hash TEXT NOT NULL,
    full_name TEXT NOT NULL,
    addr TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    CONSTRAINT username_ix UNIQUE (username)
)
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    offer_id INT NOT NULL,
    quantity INT NOT NULL,
    CONSTRAINT customer_fk FOREIGN KEY (customer_id) REFERENCES customers(id),
    CONSTRAINT offer_fk FOREIGN KEY (offer_id) REFERENCES listings.offers(id)
) TABLESPACE "ssd";

CREATE INDEX order_date_ix ON clients.orders (order_date);

COMMIT;