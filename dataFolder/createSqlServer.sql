-- Creating Database
CREATE DATABASE adera;
GO
USE adera;
-- Table adera.estabelecimento
CREATE TABLE estabelecimento (
  id UNIQUEIDENTIFIER PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  cnpj CHAR(14) NOT NULL
);

-- Table adera.maquina
CREATE TABLE maquina (
  id UNIQUEIDENTIFIER PRIMARY KEY,
  nomeMaquina VARCHAR(90) NOT NULL,
  os VARCHAR(45) NOT NULL,
  fabricante VARCHAR(45) NOT NULL,
  arquitetura INT NOT NULL,
  enderecoMac VARCHAR(45) NOT NULL,
  fkEstabelecimento UNIQUEIDENTIFIER NOT NULL,
  FOREIGN KEY (fkEstabelecimento) REFERENCES estabelecimento (id)
);

-- Table adera.unidademedida
CREATE TABLE unidademedida (
  id INT IDENTITY(1,1) PRIMARY KEY,
  nome VARCHAR(15) NOT NULL,
  abreviacao VARCHAR(5) NOT NULL
);

-- Table adera.tipocomponente
CREATE TABLE tipocomponente (
  id INT IDENTITY(1,1) PRIMARY KEY,
  nome VARCHAR(45) NOT NULL,
  fkUnidadeMedida INT NOT NULL,
  FOREIGN KEY (fkUnidadeMedida) REFERENCES unidademedida (id)
);

-- Table adera.maquinacomponente
CREATE TABLE maquinacomponente (
  id UNIQUEIDENTIFIER PRIMARY KEY,
  modelo VARCHAR(90) NOT NULL,
  descricao VARCHAR(180) NOT NULL,
  capacidade FLOAT NOT NULL,
  ativo BIT NOT NULL,
  fkMaquina UNIQUEIDENTIFIER NOT NULL,
  fkTipoComponente INT NOT NULL,
  FOREIGN KEY (fkMaquina) REFERENCES maquina (id),
  FOREIGN KEY (fkTipoComponente) REFERENCES tipocomponente (id)
);

-- Table adera.metrica
CREATE TABLE metrica (
  id UNIQUEIDENTIFIER PRIMARY KEY,
  medicao INT NOT NULL,
  data DATETIME NOT NULL,
  alertado BIT NOT NULL,
  fkMaquinaComponente UNIQUEIDENTIFIER NOT NULL,
  FOREIGN KEY (fkMaquinaComponente) REFERENCES maquinacomponente (id)
);

-- Table adera.alerta
CREATE TABLE alerta (
  id UNIQUEIDENTIFIER PRIMARY KEY,
  data DATETIME NOT NULL,
  nivel VARCHAR(10) NOT NULL,
  descricao VARCHAR(90) NOT NULL,
  fkMetrica UNIQUEIDENTIFIER NOT NULL,
  FOREIGN KEY (fkMetrica) REFERENCES metrica (id)
);

-- Table adera.endereco
CREATE TABLE endereco (
  cep CHAR(8) PRIMARY KEY,
  logradouro VARCHAR(45) NOT NULL,
  numero VARCHAR(6) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  estado CHAR(2) NOT NULL,
  complemento VARCHAR(45) NULL DEFAULT NULL,
  bairro VARCHAR(45) NOT NULL,
  fkEstabelecimento UNIQUEIDENTIFIER NOT NULL,
  FOREIGN KEY (fkEstabelecimento) REFERENCES estabelecimento (id)
);

-- Table adera.usuario
CREATE TABLE usuario (
  id UNIQUEIDENTIFIER PRIMARY KEY,
  email VARCHAR(90) NOT NULL,
  senha VARCHAR(45) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  sobrenome VARCHAR(45) NOT NULL,
  cargo VARCHAR(45) NOT NULL,
  fkEstabelecimento UNIQUEIDENTIFIER NOT NULL,
  FOREIGN KEY (fkEstabelecimento) REFERENCES estabelecimento (id)
);

-- Table adera.opcoes
CREATE TABLE opcoes (
  id INT IDENTITY(1,1) PRIMARY KEY,
  autoRestart BIT NOT NULL,
  restartPeriodico BIT NOT NULL,
  horaRestart TIME NOT NULL,
  cpuAtencao INT NOT NULL,
  ramAtencao INT NOT NULL,
  diskAtencao INT NOT NULL,
  latencyAtencao INT NOT NULL,
  cpuLimite INT NOT NULL,
  ramLimite INT NOT NULL,
  diskLimite INT NOT NULL,
  latencyLimite INT NOT NULL,
  fkEstabelecimento UNIQUEIDENTIFIER NOT NULL,
  FOREIGN KEY (fkEstabelecimento) REFERENCES estabelecimento (id)
);

SET IDENTITY_INSERT opcoes ON

-- Table adera.comando
CREATE TABLE comando (
  id UNIQUEIDENTIFIER PRIMARY KEY,
  comando VARCHAR(45) NOT NULL,
  rodou BIT NOT NULL,
  fkMaquina UNIQUEIDENTIFIER NOT NULL,
  FOREIGN KEY (fkMaquina) REFERENCES maquina (id)
);

INSERT INTO estabelecimento VALUES
  ('0b67f33a-654b-11ee-8c99-0242ac120002', 'Walmart', '24616269000165');

INSERT INTO endereco VALUES
  ('08490600', 'Rua dos Têxteis', '2746', 'São Paulo', 'SP', '32b', 'Cidade Tiradentes', '0b67f33a-654b-11ee-8c99-0242ac120002');

INSERT INTO usuario VALUES 
  ('9f2eea3a-70f7-11ee-b962-0242ac120002', 'renansilva.dev@gmail.com', 'aditum123', 'Renan', 'Silva', 'Tecnico', '0b67f33a-654b-11ee-8c99-0242ac120002');