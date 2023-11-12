DROP DATABASE IF EXISTS adera;
CREATE DATABASE IF NOT EXISTS adera;
USE adera ;

-- -----------------------------------------------------
-- Table adera.estabelecimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.estabelecimento (
  id CHAR(36) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  cnpj CHAR(14) NOT NULL,
  PRIMARY KEY (id))
;

INSERT INTO adera.estabelecimento VALUES ('78c0330e-70f7-11ee-b962-0242ac120002', 'Walmart', '24616269000165');

-- -----------------------------------------------------
-- Table adera.maquina
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.maquina (
  id CHAR(36) NOT NULL,
  os VARCHAR(45) NOT NULL,
  fabricante VARCHAR(45) NOT NULL,
  arquitetura INT NOT NULL,
  enderecoMac varchar(45) not null,
  fkEstabelecimento CHAR(36) NOT NULL,
  PRIMARY KEY (id),
  INDEX fkEstabelecimento (fkEstabelecimento ASC) VISIBLE,
  CONSTRAINT maquina_ibfk_1
    FOREIGN KEY (fkEstabelecimento)
    REFERENCES adera.estabelecimento (id))
;


-- -----------------------------------------------------
-- Table adera.unidademedida
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.unidademedida (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(15) NOT NULL,
  abreviacao VARCHAR(5) NOT NULL,
  PRIMARY KEY (id));


-- -----------------------------------------------------
-- Table adera.tipocomponente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.tipocomponente (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(45) NOT NULL,
  fkUnidadeMedida INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fkUnidadeMedida (fkUnidadeMedida ASC) VISIBLE,
  CONSTRAINT tipocomponente_ibfk_1
    FOREIGN KEY (fkUnidadeMedida)
    REFERENCES adera.unidademedida (id));

INSERT INTO adera.unidademedida VALUES 
	(null, 'byte', 'b'),
    (null, 'porcentagem', '%'),
    (null, 'heartz', 'hz');

INSERT INTO adera.tipocomponente VALUES
	(null, 'CPU', 2),
    (null, 'MEMORY', 1),
    (null, 'DISK', 1);

-- -----------------------------------------------------
-- Table adera.maquinacomponente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.maquinacomponente (
  id CHAR(36) NOT NULL,
  modelo VARCHAR(90) NOT NULL,
  descricao VARCHAR(45) NOT NULL,
  capacidade DOUBLE NOT NULL,
  fkMaquina CHAR(36) NOT NULL,
  fkTipoComponente INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fkMaquina (fkMaquina ASC) VISIBLE,
  INDEX fkTipoComponente (fkTipoComponente ASC) VISIBLE,
  CONSTRAINT maquinacomponente_ibfk_1
    FOREIGN KEY (fkMaquina)
    REFERENCES adera.maquina (id),
  CONSTRAINT maquinacomponente_ibfk_2
    FOREIGN KEY (fkTipoComponente)
    REFERENCES adera.tipocomponente (id));


-- -----------------------------------------------------
-- Table adera.metrica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.metrica (
  id CHAR(36) NOT NULL,
  medicao VARCHAR(180) NOT NULL,
  data DATETIME NOT NULL,
  fkMaquinaComponente CHAR(36) NOT NULL,
  PRIMARY KEY (id),
  INDEX fkMaquinaComponente (fkMaquinaComponente ASC) VISIBLE,
  CONSTRAINT metrica_ibfk_1
    FOREIGN KEY (fkMaquinaComponente)
    REFERENCES adera.maquinacomponente (id));


-- -----------------------------------------------------
-- Table adera.alerta
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.alerta (
  id CHAR(36) NOT NULL,
  nivel VARCHAR(10) NOT NULL,
  descricao VARCHAR(90) NOT NULL,
  fkMetrica CHAR(36) NOT NULL,
  PRIMARY KEY (id),
  INDEX fkMetrica (fkMetrica ASC) VISIBLE,
  CONSTRAINT alerta_ibfk_1
    FOREIGN KEY (fkMetrica)
    REFERENCES adera.metrica (id));


-- -----------------------------------------------------
-- Table adera.endereco
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.endereco (
  cep CHAR(8) NOT NULL,
  logradouro VARCHAR(45) NOT NULL,
  numero VARCHAR(6) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  estado CHAR(2) NOT NULL,
  complemento VARCHAR(45) NULL DEFAULT NULL,
  bairro VARCHAR(45) NOT NULL,
  fkEstabelecimento CHAR(36) NOT NULL,
  INDEX fkEstabelecimento (fkEstabelecimento ASC) VISIBLE,
  CONSTRAINT endereco_ibfk_1
    FOREIGN KEY (fkEstabelecimento)
    REFERENCES adera.estabelecimento (id));


-- -----------------------------------------------------
-- Table adera.usuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.usuario (
  id CHAR(36) NOT NULL,
  email VARCHAR(90) NOT NULL,
  senha VARCHAR(45) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  sobrenome VARCHAR(45) NOT NULL,
  cargo VARCHAR(45) NOT NULL,
  fkEstabelecimento CHAR(36) NOT NULL,
  PRIMARY KEY (id),
  INDEX fkEstabelecimento (fkEstabelecimento ASC) VISIBLE,
  CONSTRAINT usuario_ibfk_1
    FOREIGN KEY (fkEstabelecimento)
    REFERENCES adera.estabelecimento (id));

-- -----------------------------------------------------
-- Table adera.opcoes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.opcoes (
	id INT NOT NULL,
    autoRestart BOOLEAN NOT NULL,
    restartPeriodico BOOLEAN NOT NULL,
    horaRestart TIME NOT NULL,
    cpuLimite INT NOT NULL,
    ramLimite INT NOT NULL,
    diskLimite INT NOT NULL,
    fkEstabelecimento CHAR(36) NOT NULL,
    PRIMARY KEY (id, fkEstabelecimento),
    INDEX fkEstabelecimento (fkEstabelecimento ASC) VISIBLE,
    CONSTRAINT opcoes_ibfk_1
		FOREIGN KEY (fkEstabelecimento)
        REFERENCES adera.estabelecimento (id));
        
-- -----------------------------------------------------
-- Table adera.comando
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS adera.comando (
	id CHAR(36) NOT NULL,
    comando INT NOT NULL,
    rodou BOOLEAN NOT NULL,
    fkMaquina CHAR(36) NOT NULL,
    INDEX fkMaquina (fkMaquina ASC) VISIBLE,
    CONSTRAINT comando_ibfk_1
		FOREIGN KEY (fkMaquina)
        REFERENCES adera.maquina (id));

delimiter //

CREATE PROCEDURE adera.inserirEstabelecimento (IN id CHAR(36), IN nome VARCHAR(45), IN cnpj CHAR(14), IN cep CHAR(8), IN logradouro CHAR(45), IN numero VARCHAR(6), IN cidade VARCHAR(45), IN estado CHAR(2), IN complemento VARCHAR(45), IN bairro VARCHAR(45))
BEGIN
	START TRANSACTION;
	INSERT INTO adera.estabelecimento VALUES (id, nome, cnpj);
    INSERT INTO adera.endereco VALUES (cep, logradouro, numero, cidade, estado, complemento, bairro, id);
    INSERT INTO adera.opcoes VALUES (1, false, false, "00:00:00", 100, 100, 100, 100);
    COMMIT;
END//

INSERT INTO estabelecimento VALUES
	('0b67f33a-654b-11ee-8c99-0242ac120002', 'Walmart', '24616269000165');

INSERT INTO endereco VALUES
	('08490600', 'Rua dos Têxteis', '2746', 'São Paulo', 'SP', '32b', 'Cidade Tiradentes', '0b67f33a-654b-11ee-8c99-0242ac120002');

INSERT INTO adera.usuario VALUES 
	('9f2eea3a-70f7-11ee-b962-0242ac120002', 'renansilva.dev@gmail.com', 'aditum123', 'Renan', 'Silva', 'Tecnico', '0b67f33a-654b-11ee-8c99-0242ac120002');
