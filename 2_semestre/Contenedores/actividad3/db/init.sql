CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  price NUMERIC(10, 2) NOT NULL
);

INSERT INTO products (name, price) VALUES
('Nintendo Switch 2', 9999.99),
('PS5', 7999.99),
('Xbox Series X', 7499.99)
ON CONFLICT DO NOTHING;
