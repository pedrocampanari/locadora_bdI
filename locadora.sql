\c locadora
drop table if exists Pessoa_Juridica; 
drop table if exists Pessoa_Fisica; 
drop table if exists Pessoa; 
drop table if exists Fabricante_Veiculo;
drop table if exists Endereco; 


create table Endereco
(
    id serial not null primary key,
    logradouro varchar(20) not null,
    bairro varchar(20) not null,
    numero int null,
    cidade varchar(20) not null,
    cep varchar(9) not null
);


create table Pessoa
(
    id int not null primary key,
    nome varchar(60) NOT NULL,
    endereco_ID int not null references Endereco(id)
);

create table Pessoa_Fisica
(   
    pessoa_id int primary key,
    cpf varchar(14) not null unique,
    constraint fk_pessoa foreign key (pessoa_id) references Pessoa(id) on delete cascade
);

create table Pessoa_Juridica
(   
    pessoa_id int primary key,
    cnpj varchar(18) not null unique,
    constraint fk_pessoa foreign key (pessoa_id) references Pessoa(id) on delete cascade
);






create table Fabricante_Veiculo
(
    id serial not null primary key,
    cnpj varchar(18) not null unique,
    nome varchar(20) not null, 
    endereco_fabricante_id int not null references Endereco(id)
);


-- Inserindo enderecos
insert into Endereco(logradouro, numero, bairro, cidade, cep)
values 
    ('Av. Jary Mercante', 2551, 'Jardim Alvorada', 'Três Lagoas', '79610-001'),
    ('Av. Jary Mercante', 2550, 'Jardim Alvorada', 'Três Lagoas', '79610-001'),
    ('Av. Jary Mercante', 2552, 'Jardim Alvorada', 'Três Lagoas', '79610-001');

-- Inserindo algumas pessoas 
insert into Pessoa(id, nome, endereco_ID)
values (1, 'Pedro Campanari', 1);

insert into Pessoa_Fisica(pessoa_id, cpf)
values (1, '123.456.798-19');

insert into Pessoa(id, nome, endereco_ID)
values (2, 'Arthur Henrique', 2);

insert into Pessoa_Fisica(pessoa_id, cpf)
values (2, '123.456.798-10');

insert into Pessoa(id, nome, endereco_ID)
values (3, 'Humberto Lemos', 3);

insert into Pessoa_Fisica(pessoa_id, cpf)
values (3, '123.456.798-02');





