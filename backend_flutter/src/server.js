
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import clientesRouter from './routes/clientes.js';
import produtosRouter from './routes/produtos.js';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/', (req,res)=> res.json({message: 'API Desafio Final'}));

app.use('/clientes', clientesRouter);
app.use('/produtos', produtosRouter);

app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});
