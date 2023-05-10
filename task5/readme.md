# Отчет о проделанном задании

## Настройка базы данных, пользователя, схемы, таблиц

Настроено в задании №4

## Начальное заполнение данными

1. Я создал файл `fill-tables.sql` и выполнил скрипт `$ bash client/run-sql.sh sql/fill-tables.sql`, и заполнил используемые базы данных.

## Запрос с регулярным выражением

1. Я выполнил SQL запрос: `SELECT * FROM listings.products WHERE product_name LIKE 'Nike%';` из файла `sql/regex-query.sql`.
2. База данных вернула строки:

```
   id | product_name | description | manufacturer_id | category_id
   ----+--------------+-------------+-----------------+-------------
   0 | Nike AirMax | Cool shoes | 0 | 0
   (1 row)
```

3. Мы нашли кроссовки от фирмы Nike

## Запрос с JOIN

1. Я выполнил SQL запрос (файл `select.sql`):

   ```sql
   SELECT
       *
   FROM
       listings.products p
   LEFT JOIN
       listings.offers o
   ON
       o.product_id = p.id
   ```

   ```
    id |  product_name   | description | manufacturer_id | category_id | id | product_id | seller_id | price | quantity | offer_start_date | offer_end_date
   ----+-----------------+-------------+-----------------+-------------+----+------------+-----------+-------+----------+------------------+----------------
     0 | Nike AirMax     | Cool shoes  |               0 |           0 |  0 |          0 |         0 |   100 |      100 | 2023-05-10       | 2030-10-30
     1 | Adidas Yeezy    | Cool shoes  |               1 |           0 |  1 |          1 |         1 |  99.9 |      200 | 2023-05-10       | 2031-10-30
     2 | New Balance 574 | Cool shoes  |               1 |           0 |    |            |           |       |          |                  |
   (3 rows)
   ```

   С помощью него можно посмотреть, какие сейчас существуют продукты и предложения на них, причем продукты показываются все, даже если на них нет предложений. Если выполнить JOIN в другом порядке, то продукты без предложений не будут показаны (потому что `LEFT JOIN` берет все строки в левой таблице, и мерджит к ним строки из правой, если они подходят по критерию)

2. С `INNER JOIN`:

   ```sql
   SELECT
    *
   FROM
    listings.products p
   INNER JOIN
    listings.offers o
   ON
    o.product_id = p.id
   ```

   ```
    id | product_name | description | manufacturer_id | category_id | id | product_id | seller_id | price | quantity | offer_start_date | offer_end_date
   ----+--------------+-------------+-----------------+-------------+----+------------+-----------+-------+----------+------------------+----------------
   0 | Nike AirMax  | Cool shoes  |               0 |           0 |  0 |          0 |         0 |   100 |      100 | 2023-05-10       | 2030-10-30
   1 | Adidas Yeezy | Cool shoes  |               1 |           0 |  1 |          1 |         1 |  99.9 |      200 | 2023-05-10       | 2031-10-30
   (2 rows)
   ```

   Результат тот же, что и в прошлом пункте, если поменять порядок в `LEFT JOIN`, т.к. у нас есть внешний ключ у таблицы `offers`, и не существует предложений без ассоциированного продукта

## Запрос на добавление данных с выводом информации о добавленных строках

(файл `sql/insert.sql`)

```sql
INSERT INTO listings.manufacturers (company_name, addr)
VALUES ('Skechers', 'Some Address'), ('Asics', 'Some Address') RETURNING id;
```

```
 id
----
  6
  7
(2 rows)
```

## Запрос с обновлением данных через UPDATE FROM

(файл `update-from.sql`)

```sql
UPDATE listings.manufacturers m
SET addr = s.addr
FROM listings.sellers s
WHERE s.company_name = m.company_name
```

## Запрос DELETE используя JOIN с помощью USING

Сначала добавил некорректный заказ (заказ на большее кол-во товара, чем есть на складе)

```sql
INSERT INTO clients.orders (customer_id, order_date, offer_id, quantity)
VALUES (0, NOW(), 0, 200)
```

```
 id | customer_id | order_date | offer_id | quantity
----+-------------+------------+----------+----------
  5 |           0 | 2023-05-10 |        0 |      200
  6 |           0 | 2023-05-10 |        0 |        1
```

```sql
DELETE FROM clients.orders ord
USING listings.offers of
WHERE of.id = offer_id AND of.quantity < ord.quantity;
```

Удалились заказы, где кол-во превышает запасы:

```
 id | customer_id | order_date | offer_id | quantity
----+-------------+------------+----------+----------
  6 |           0 | 2023-05-10 |        0 |        1
(1 row)
```
