\c locadora

SELECT * FROM Pessoa;

SELECT nome FROM Pessoa;

SELECT * FROM Pessoa ORDER BY nome;

SELECT id, nome
FROM Pessoa
WHERE nome ILIKE '%pedro%'
ORDER BY nome;


-- Pessoas de determinada cidade
SELECT P.nome, P.telefone, C.nome AS cidade, C.estado
FROM Pessoa P JOIN Cidade C
   ON (P.cidade_id = C.id)
WHERE C.nome = 'Três Lagoas'
ORDER BY P.nome;

-- Individuos cadastrados
SELECT P.id, P.nome, PF.cpf, PF.rg
FROM Pessoa P JOIN Pessoa_Fisica PF
   ON (PF.pessoa_id = P.id)
ORDER BY P.nome;

-- Organizacoes cadastradas
SELECT P.id, PJ.razao_social, PJ.nome_fantasia, PJ.cnpj
FROM Pessoa P JOIN Pessoa_Juridica PJ
   ON (PJ.pessoa_id = P.id)
ORDER BY PJ.razao_social;

-- Todas as pessoas, fisicas e juridicas
SELECT P.nome,
  COALESCE(PF.cpf, PJ.cnpj) AS documento,
  CASE WHEN PF.pessoa_id IS NOT NULL THEN 'Física' ELSE 'Jurídica' END AS tipo
FROM Pessoa P LEFT JOIN Pessoa_Fisica PF ON (PF.pessoa_id = P.id)
   LEFT JOIN Pessoa_Juridica PJ ON (PJ.pessoa_id = P.id)
ORDER BY P.nome;

-- Funcionarios que atuam como vendedores
SELECT P.nome, F.matricula, F.salario_base, V.percentual_comissao
FROM Vendedor V JOIN Funcionario F ON (V.funcionario_id = F.pessoa_fisica_id)
   JOIN Pessoa P ON (F.pessoa_fisica_id = P.id)
ORDER BY P.nome;

-- Proprietarios e seus veiculos
SELECT P.nome AS proprietario, V.placa, M.nome AS modelo, V.condicao
FROM Veiculo V JOIN Proprietario PR ON (V.proprietario_id = PR.pessoa_id)
   JOIN Pessoa P ON (PR.pessoa_id = P.id)
   JOIN Modelo M ON (V.modelo_id = M.id)
ORDER BY P.nome;

-- Historico de locacoes
SELECT L.id, Cli.nome AS cliente, V.placa, Vend.nome AS vendedor,
  L.data_retirada, L.data_devolucao, L.valor_total
FROM Locacao L JOIN Pessoa Cli ON (L.cliente_id = Cli.id)
   JOIN Veiculo V ON (L.veiculo_id = V.id)
   JOIN Pessoa Vend ON (L.vendedor_id = Vend.id)
ORDER BY L.data_retirada;


SELECT COUNT(*) FROM Pessoa;

-- Quantidade de pessoas por cidade
SELECT C.nome AS cidade, COUNT(*) AS total
FROM Pessoa P JOIN Cidade C
   ON (P.cidade_id = C.id)
GROUP BY C.nome
ORDER BY total DESC;
