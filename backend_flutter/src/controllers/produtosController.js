
import { getConnection } from '../db/index.js';

export async function listar(req,res){
  const conn = await getConnection();
  const [rows] = await conn.query('SELECT * FROM produtos');
  await conn.end();
  res.json(rows);
}

export async function buscarPorId(req,res){
  const conn = await getConnection();
  const [rows] = await conn.query('SELECT * FROM produtos WHERE id = ?', [req.params.id]);
  await conn.end();
  if(rows.length === 0) return res.status(404).json({message:'Produto não encontrado'});
  res.json(rows[0]);
}

export async function criar(req,res){
  const { nome, descricao, preco, data_atualizado } = req.body;
  const conn = await getConnection();
  const [result] = await conn.query(
    'INSERT INTO produtos (nome, descricao, preco, data_atualizado) VALUES (?,?,?,?)',
    [nome, descricao, preco, data_atualizado]
  );
  const [rows] = await conn.query('SELECT * FROM produtos WHERE id = ?', [result.insertId]);
  await conn.end();
  res.status(201).json(rows[0]);
}

export async function atualizar(req,res){
  const { nome, descricao, preco, data_atualizado } = req.body;
  const conn = await getConnection();
  await conn.query(
    'UPDATE produtos SET nome=?, descricao=?, preco=?, data_atualizado=? WHERE id=?',
    [nome, descricao, preco, data_atualizado, req.params.id]
  );
  const [rows] = await conn.query('SELECT * FROM produtos WHERE id = ?', [req.params.id]);
  await conn.end();
  if(rows.length === 0) return res.status(404).json({message:'Produto não encontrado'});
  res.json(rows[0]);
}

export async function remover(req,res){
  const conn = await getConnection();
  await conn.query('DELETE FROM produtos WHERE id=?', [req.params.id]);
  await conn.end();
  res.status(204).send();
}
