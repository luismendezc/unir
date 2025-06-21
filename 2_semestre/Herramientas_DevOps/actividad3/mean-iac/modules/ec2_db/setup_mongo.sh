#!/bin/bash
set -e

sudo apt update
sudo apt install -y gnupg curl

curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
  sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg

echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/7.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

sudo apt update

sudo apt-get install -f -y
sudo apt-get clean
sudo apt-get autoremove -y

sudo apt install -y mongodb-org

sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

sudo systemctl enable mongod
sudo systemctl restart mongod

for i in {1..10}; do
  if nc -z localhost 27017; then
    break
  fi
  sleep 2
done

mongosh <<EOF
use tienda
db.producto.deleteMany({})
db.producto.insertMany([
  { nombre: "Laptop", precio: 1200, stock: 10 },
  { nombre: "Mouse", precio: 25, stock: 100 },
  { nombre: "Teclado", precio: 45, stock: 50 }
])
EOF