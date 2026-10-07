\c locadora

DROP TABLE IF EXISTS Locacao;
DROP TABLE IF EXISTS Veiculo;
DROP TABLE IF EXISTS Tipo_Propulsao;
DROP TABLE IF EXISTS Cor;
DROP TABLE IF EXISTS Modelo;
DROP TABLE IF EXISTS Fabricante;
DROP TABLE IF EXISTS Gerente;
DROP TABLE IF EXISTS Setor;
DROP TABLE IF EXISTS Vendedor;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Proprietario;
DROP TABLE IF EXISTS Locadora;
DROP TABLE IF EXISTS Pessoa_Juridica;
DROP TABLE IF EXISTS Pessoa_Fisica;
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Cidade;


CREATE TABLE Cidade
(
    id serial NOT NULL PRIMARY KEY,
    nome varchar(60) NOT NULL,
    estado char(2) NOT NULL
);


CREATE TABLE Pessoa
(
    id serial NOT NULL PRIMARY KEY,
    nome varchar(60) NOT NULL,
    telefone varchar(16) NOT NULL,
    email varchar(60) NULL,
    cidade_id int NOT NULL REFERENCES Cidade(id)
);

CREATE TABLE Pessoa_Fisica
(
    pessoa_id int NOT NULL PRIMARY KEY REFERENCES Pessoa(id),
    cpf varchar(14) NOT NULL UNIQUE,
    rg varchar(20) NOT NULL
);

CREATE TABLE Pessoa_Juridica
(
    pessoa_id int NOT NULL PRIMARY KEY REFERENCES Pessoa(id),
    cnpj varchar(18) NOT NULL UNIQUE,
    razao_social varchar(100) NOT NULL,
    nome_fantasia varchar(60) NOT NULL
);

CREATE TABLE Locadora
(
    pessoa_juridica_id int NOT NULL PRIMARY KEY REFERENCES Pessoa_Juridica(pessoa_id)
);


CREATE TABLE Proprietario
(
    pessoa_id int NOT NULL PRIMARY KEY REFERENCES Pessoa(id),
    proprietario_desde date NOT NULL,
    numero_ultimo_contrato varchar(30) NOT NULL
);

CREATE TABLE Cliente
(
    pessoa_id int NOT NULL PRIMARY KEY REFERENCES Pessoa(id),
    data_liberacao_colecionador date NULL
);


CREATE TABLE Funcionario
(
    pessoa_fisica_id int NOT NULL PRIMARY KEY REFERENCES Pessoa_Fisica(pessoa_id),
    matricula varchar(20) NOT NULL UNIQUE,
    data_admissao date NOT NULL,
    salario_base numeric(9,2) NOT NULL,
    locadora_id int NOT NULL REFERENCES Locadora(pessoa_juridica_id)
);

CREATE TABLE Vendedor
(
    funcionario_id int NOT NULL PRIMARY KEY REFERENCES Funcionario(pessoa_fisica_id),
    percentual_comissao numeric(5,2) NOT NULL
);

CREATE TABLE Setor
(
    id serial NOT NULL PRIMARY KEY,
    nome varchar(40) NOT NULL,
    locadora_id int NOT NULL REFERENCES Locadora(pessoa_juridica_id)
);

CREATE TABLE Gerente
(
    funcionario_id int NOT NULL PRIMARY KEY REFERENCES Funcionario(pessoa_fisica_id),
    setor_id int NOT NULL REFERENCES Setor(id)
);


CREATE TABLE Fabricante
(
    id serial NOT NULL PRIMARY KEY,
    nome varchar(40) NOT NULL,
    ano_fundacao int NOT NULL,
    pais_origem varchar(40) NOT NULL
);

CREATE TABLE Modelo
(
    id serial NOT NULL PRIMARY KEY,
    nome varchar(40) NOT NULL,
    potencia_cv int NOT NULL,
    consumo_medio_km_l numeric(5,2) NOT NULL,
    tipo_cambio varchar(20) NOT NULL,
    numero_marchas int NOT NULL,
    capacidade_porta_malas_l int NOT NULL,
    ano_lancamento int NOT NULL,
    ano_final_producao int NULL,
    torque_kgfm numeric(5,2) NOT NULL,
    velocidade_maxima_kmh int NOT NULL,
    aceleracao_0_100_s numeric(4,1) NOT NULL,
    fabricante_id int NOT NULL REFERENCES Fabricante(id)
);

CREATE TABLE Cor
(
    id serial NOT NULL PRIMARY KEY,
    nome varchar(30) NOT NULL,
    codigo_hex char(7) NOT NULL,
    tipo varchar(20) NOT NULL,
    acabamento varchar(20) NOT NULL,
    caracteristicas_pintura varchar(200) NULL
);

CREATE TABLE Tipo_Propulsao
(
    id serial NOT NULL PRIMARY KEY,
    nome varchar(30) NOT NULL,
    descricao varchar(200) NOT NULL,
    usa_tanque boolean NOT NULL,
    usa_bateria boolean NOT NULL
);

CREATE TABLE Veiculo
(
    id serial NOT NULL PRIMARY KEY,
    placa varchar(8) NOT NULL UNIQUE,
    chassi varchar(17) NOT NULL UNIQUE,
    preco_venda numeric(10,2) NOT NULL,
    ano_fabricacao int NOT NULL,
    quilometragem_atual int NOT NULL,
    condicao varchar(20) NOT NULL,
    valor_diaria numeric(9,2) NOT NULL,
    proprietario_id int NOT NULL REFERENCES Proprietario(pessoa_id),
    modelo_id int NOT NULL REFERENCES Modelo(id),
    cor_id int NOT NULL REFERENCES Cor(id),
    tipo_propulsao_id int NOT NULL REFERENCES Tipo_Propulsao(id)
);


CREATE TABLE Locacao
(
    id serial NOT NULL PRIMARY KEY,
    cliente_id int NOT NULL REFERENCES Cliente(pessoa_id),
    veiculo_id int NOT NULL REFERENCES Veiculo(id),
    locadora_id int NOT NULL REFERENCES Locadora(pessoa_juridica_id),
    vendedor_id int NOT NULL REFERENCES Vendedor(funcionario_id),
    data_retirada timestamp NOT NULL,
    data_prevista_devolucao timestamp NOT NULL,
    data_devolucao timestamp NULL,
    km_inicial int NOT NULL,
    km_final int NULL,
    valor_total numeric(9,2) NULL
);
