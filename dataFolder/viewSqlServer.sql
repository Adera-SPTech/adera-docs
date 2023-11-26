USE adera;
GO

-- Creating Views
CREATE VIEW maquina_status AS
SELECT
    m.id AS maquina_id,
    m.nomeMaquina,
    m.os,
    m.fabricante,
    m.arquitetura,
    m.enderecoMac,
    m.fkEstabelecimento,
    CASE
        WHEN DATEDIFF(SECOND, MAX(metrica.data), GETDATE()) <= 30 THEN 1
        ELSE 0
    END AS isOnline,
    MAX(metrica.medicao) AS diskUsage
FROM
    maquina m
LEFT JOIN maquinacomponente mc ON m.id = mc.fkMaquina
LEFT JOIN metrica metrica ON mc.id = metrica.fkMaquinaComponente AND mc.fkTipoComponente = (SELECT id FROM tipocomponente WHERE nome = 'DISK')
GROUP BY
    m.id, m.nomeMaquina, m.os, m.fabricante, m.arquitetura, m.enderecoMac, m.fkEstabelecimento;

GO
CREATE VIEW last_problem AS
SELECT
    m.id AS machine_id,
    m.nomeMaquina AS machine_name,
    a.id AS alert_id,
    a.nivel AS alert_level,
    a.descricao AS alert_description,
    a.data AS alert_date
FROM
    maquina m
JOIN
    maquinacomponente mc ON m.id = mc.fkMaquina
JOIN
    metrica met ON mc.id = met.fkMaquinaComponente
JOIN
    alerta a ON met.id = a.fkMetrica
WHERE
    a.data >= GETDATE() - 7
ORDER BY
    a.data DESC
OFFSET 0 ROWS FETCH FIRST 1 ROW ONLY;