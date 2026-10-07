\c locadora

INSERT INTO Cidade (nome, estado)
   VALUES
      ('Três Lagoas', 'MS'),
      ('Campo Grande', 'MS');

-- Inserindo algumas pessoas
INSERT INTO Pessoa (id, nome, telefone, email, cidade_id)
   VALUES
      (1, 'Pedro Campanari', '67 99999-0001', NULL, 1),
      (2, 'Arthur Henrique', '67 99999-0002', NULL, 1),
      (3, 'Humberto Lemos', '67 99999-0003', NULL, 1),
      (4, 'Locadora Alfa', '67 3333-0000', 'contato@alfa.com', 2);

SELECT setval('pessoa_id_seq', 4);

INSERT INTO Pessoa_Fisica (pessoa_id, cpf, rg)
   VALUES
      (1, '123.456.798-19', '0000001'),
      (2, '123.456.798-10', '0000002'),
      (3, '123.456.798-02', '0000003');

INSERT INTO Pessoa_Juridica (pessoa_id, cnpj, razao_social, nome_fantasia)
   VALUES (4, '00.000.000/0001-00', 'Alfa Locacao de Veiculos LTDA', 'Locadora Alfa');

INSERT INTO Locadora (pessoa_juridica_id)
   VALUES (4);

-- Pedro e proprietario, funcionario (vendedor) e tambem cliente
INSERT INTO Proprietario (pessoa_id, proprietario_desde, numero_ultimo_contrato)
   VALUES
      (1, '2024/03/10', 'CT-0001'),
      (4, '2020/01/01', 'CT-0002');

INSERT INTO Funcionario (pessoa_fisica_id, matricula, data_admissao, salario_base, locadora_id)
   VALUES
      (1, 'F001', '2025/02/01', 2500, 4),
      (3, 'F002', '2023/06/15', 6000, 4);

INSERT INTO Vendedor (funcionario_id, percentual_comissao)
   VALUES (1, 5);

INSERT INTO Setor (nome, locadora_id)
   VALUES ('Frota', 4);

INSERT INTO Gerente (funcionario_id, setor_id)
   VALUES (3, 1);

INSERT INTO Cliente (pessoa_id, data_liberacao_colecionador)
   VALUES
      (1, NULL),
      (2, '2026/01/10');

INSERT INTO Fabricante (nome, ano_fundacao, pais_origem)
   VALUES ('Volkswagen', 1937, 'Alemanha');

INSERT INTO Modelo (nome, potencia_cv, consumo_medio_km_l, tipo_cambio, numero_marchas,
      capacidade_porta_malas_l, ano_lancamento, ano_final_producao, torque_kgfm,
      velocidade_maxima_kmh, aceleracao_0_100_s, fabricante_id)
   VALUES ('Fusca', 50, 11, 'Manual', 4, 140, 1959, 1996, 10.8, 135, 30, 1);

INSERT INTO Cor (nome, codigo_hex, tipo, acabamento, caracteristicas_pintura)
   VALUES ('Azul', '#1E3A8A', 'Sólida', 'Brilhante', NULL);

INSERT INTO Tipo_Propulsao (nome, descricao, usa_tanque, usa_bateria)
   VALUES ('Combustão', 'Motor a combustão interna', true, false);

INSERT INTO Veiculo (placa, chassi, preco_venda, ano_fabricacao, quilometragem_atual,
      condicao, valor_diaria, proprietario_id, modelo_id, cor_id, tipo_propulsao_id)
   VALUES
      ('ABC1D23', '9BWZZZ11ZZP000001', 45000, 1975, 120000, 'de Colecionador', 400, 1, 1, 1, 1),
      ('XYZ9K87', '9BWZZZ11ZZP000002', 30000, 1990, 80000, 'Bom', 150, 4, 1, 1, 1);

INSERT INTO Locacao (cliente_id, veiculo_id, locadora_id, vendedor_id, data_retirada,
      data_prevista_devolucao, data_devolucao, km_inicial, km_final, valor_total)
   VALUES
      (2, 1, 4, 1, '2026/02/01 09:00', '2026/02/05 09:00', '2026/02/05 10:30', 119500, 120000, 1600),
      (2, 2, 4, 1, '2026/03/10 14:00', '2026/03/12 14:00', NULL, 80000, NULL, NULL);
