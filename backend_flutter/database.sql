
CREATE DATABASE IF NOT EXISTS desafio_flutter CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE desafio_flutter;

DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS produtos;

CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  sobrenome VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  idade INT NOT NULL,
  foto VARCHAR(255) NULL
);

CREATE TABLE produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  descricao TEXT NOT NULL,
  preco DECIMAL(10,2) NOT NULL,
  data_atualizado DATETIME NOT NULL
);

INSERT INTO clientes (nome, sobrenome, email, idade, foto) VALUES
('João', 'Silva', 'joao.silva@example.com', 30, ''),
('Maria', 'Oliveira', 'maria.oliveira@example.com', 25, ''),
('Carlos', 'Souza', 'carlos.souza@example.com', 40, '');

INSERT INTO produtos (nome, descricao, preco, data_atualizado) VALUES
('Notebook', 'Notebook i5 8GB RAM', 3500.00, NOW()),
('Mouse Gamer', 'Mouse com 6 botões e LED', 150.00, NOW()),
('Teclado Mecânico', 'Teclado ABNT2 mecânico', 450.00, NOW());
