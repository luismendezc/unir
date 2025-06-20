FROM node:20-alpine

# Crear usuario sin privilegios
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --omit=dev

COPY . .
USER appuser
EXPOSE 3000

CMD ["npm", "start"]
