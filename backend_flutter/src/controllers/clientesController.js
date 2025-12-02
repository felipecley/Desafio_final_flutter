
import { getConnection } from '../db/index.js';

export async function listar(req,res){
  const conn = await getConnection();
  const [rows] = await conn.query('SELECT * FROM clientes');
  await conn.end();
  res.json(rows);
}

export async function buscarPorId(req,res){
  const conn = await getConnection();
  const [rows] = await conn.query('SELECT * FROM clientes WHERE id = ?', [req.params.id]);
  await conn.end();
  if(rows.length === 0) return res.status(404).json({message:'Cliente não encontrado'});
  res.json(rows[0]);
}

export async function criar(req,res){
  const { nome, sobrenome, email, idade, foto } = req.body;
  const conn = await getConnection();
  const [result] = await conn.query(
    'INSERT INTO clientes (nome, sobrenome, email, idade, foto) VALUES (?,?,?,?,?)',
    [nome, sobrenome, email, idade, foto]
  );
  const [rows] = await conn.query('SELECT * FROM clientes WHERE id = ?', [result.insertId]);
  await conn.end();
  res.status(201).json(rows[0]);
}

export async function atualizar(req,res){
  const { nome, sobrenome, email, idade, foto } = req.body;
  const conn = await getConnection();
  await conn.query(
    'UPDATE clientes SET nome=?, sobrenome=?, email=?, idade=?, foto=? WHERE id=?',
    [nome, sobrenome, email, idade, foto, req.params.id]
  );
  const [rows] = await conn.query('SELECT * FROM clientes WHERE id = ?', [req.params.id]);
  await conn.end();
  if(rows.length === 0) return res.status(404).json({message:'Cliente não encontrado'});
  res.json(rows[0]);
}

export async function remover(req,res){
  const conn = await getConnection();
  await conn.query('DELETE FROM clientes WHERE id=?', [req.params.id]);
  await conn.end();
  res.status(204).send();
}
