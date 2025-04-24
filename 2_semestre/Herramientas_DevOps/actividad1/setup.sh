#!/bin/bash

# Actualiza e instala dependencias
sudo apt update
sudo apt install -y nginx curl build-essential

# Instala Node.js y npm
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs
sudo npm install -g pm2

# Crea la app hello.js
cat <<EOF > /home/ubuntu/hello.js
const http = require('http');
const hostname = 'localhost';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World!\\n');
});

server.listen(port, hostname, () => {
  console.log(\`Server running at http://\${hostname}:\${port}/\`);
});
EOF

sudo chown ubuntu:ubuntu /home/ubuntu/hello.js
pm2 start /home/ubuntu/hello.js
pm2 startup systemd -u ubuntu --hp /home/ubuntu
pm2 save

# Configura Nginx como proxy
sudo rm /etc/nginx/sites-enabled/default
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
