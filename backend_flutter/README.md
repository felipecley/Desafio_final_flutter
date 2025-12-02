
# Backend Desafio Final

API REST em Node.js + Express + MySQL para integração com o app Flutter.

## Rotas

- GET    /clientes
- GET    /clientes/:id
- POST   /clientes
- PUT    /clientes/:id
- DELETE /clientes/:id

- GET    /produtos
- GET    /produtos/:id
- POST   /produtos
- PUT    /produtos/:id
- DELETE /produtos/:id

## Como rodar

1. Instale o Node.js (https://nodejs.org).
2. Crie um banco MySQL usando o script `database.sql`.
3. Copie `.env.example` para `.env` e ajuste usuário/senha do MySQL.
4. Instale as dependências:

   npm install

5. Inicie o servidor:

   npm start

O servidor rodará em `http://localhost:3000`.
