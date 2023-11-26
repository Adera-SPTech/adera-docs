USE adera;
GO

-- Creating Procedure
CREATE PROCEDURE inserirEstabelecimento 
  @id UNIQUEIDENTIFIER,
  @nome VARCHAR(45),
  @cnpj CHAR(14),
  @cep CHAR(8),
  @logradouro CHAR(45),
  @numero VARCHAR(6),
  @cidade VARCHAR(45),
  @estado CHAR(2),
  @complemento VARCHAR(45),
  @bairro VARCHAR(45)
AS
BEGIN
	-- Using TRANSACTION to ensure atomicity
	BEGIN TRANSACTION;

	INSERT INTO estabelecimento VALUES (@id, @nome, @cnpj);
    INSERT INTO endereco VALUES (@cep, @logradouro, @numero, @cidade, @estado, @complemento, @bairro, @id);
    INSERT INTO opcoes (
  autoRestart, 
  restartPeriodico, 
  horaRestart, 
  cpuAtencao, 
  ramAtencao, 
  diskAtencao, 
  latencyAtencao, 
  cpuLimite, 
  ramLimite, 
  diskLimite, 
  latencyLimite, 
  fkEstabelecimento
)
VALUES (
  0, -- autoRestart
  0, -- restartPeriodico
  '00:00:00', -- horaRestart
  100, -- cpuAtencao
  100, -- ramAtencao
  100, -- diskAtencao
  100, -- latencyAtencao
  100, -- cpuLimite
  100, -- ramLimite
  100, -- diskLimite
  100, -- latencyLimite
  @id -- Replace with the actual value for fkEstabelecimento
);

	COMMIT;
END;