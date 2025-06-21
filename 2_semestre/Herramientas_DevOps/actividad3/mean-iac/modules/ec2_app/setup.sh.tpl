#!/bin/bash
set -e

sudo apt update
sudo apt install -y curl gnupg

sudo apt update
sudo apt install -y nginx

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g pm2
sudo npm install mongodb || true

echo "=== INICIO CREACION hello.js ==="
cat <<EOF > /home/ubuntu/hello.js
const http = require('http');
const { MongoClient } = require('mongodb');
const hostname = '0.0.0.0';
const port = 3000;
const mongoUrl = 'mongodb://${db_private_ip}:27017';
const dbName = 'tienda';

const server = http.createServer(async (req, res) => {
  if (req.url === '/productos') {
    try {
      const client = await MongoClient.connect(mongoUrl, { useUnifiedTopology: true });
      const db = client.db(dbName);
      const productos = await db.collection('producto').find().toArray();
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify(productos));
      client.close();
    } catch (err) {
      res.writeHead(500, { 'Content-Type': 'text/plain' });
      res.end('Error consultando MongoDB');
    }
  } else {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello World!\\n');
  }
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://$${hostname}:$${port}/`);
});
EOF
echo "=== FIN CREACION hello.js ==="

chown ubuntu:ubuntu /home/ubuntu/hello.js
sudo -u ubuntu npm install --prefix /home/ubuntu mongodb
sudo -u ubuntu pm2 start /home/ubuntu/hello.js
sudo -u ubuntu pm2 save
sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u ubuntu --hp /home/ubuntu


sudo mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled
sudo rm -f /etc/nginx/sites-enabled/default

cat <<EOF | sudo tee /etc/nginx/sites-available/nodeapp
server {
  listen 80;
  location / {
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host \$host;
    proxy_cache_bypass \$http_upgrade;
  }
}
EOF

sudo ln -s /etc/nginx/sites-available/nodeapp /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
