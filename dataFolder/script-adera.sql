drop database if exists adera;
create database if not exists adera;
use adera;

create table estabelecimento (
	id char(36) primary key,
    nome varchar(45) not null,
    cnpj char(14) not null
);

create table endereco (
	cep char(8) not null,
	logradouro varchar(45) not null,
    numero varchar(6) not null,
    cidade varchar(45) not null,
    estado char(2) not null,
    complemento varchar(45),
    bairro varchar(45) not null,
    fkEstabelecimento char(36) not null,
    foreign key (fkEstabelecimento) references estabelecimento(id)
);
create table usuario (
	id char(36) primary key,
    email varchar(90) not null,
    senha varchar(45) not null,
    nome varchar(45) not null,
    sobrenome varchar(45) not null,
    cargo varchar(45) not null,
    fkEstabelecimento char(36) not null,
    foreign key (fkEstabelecimento) references estabelecimento(id)
);

create table maquina (
	id char(36) primary key,
    os varchar(45) not null,
    fabricante varchar(45) not null,
    arquitetura int not null,
    fkEstabelecimento char(36) not null,
    foreign key (fkEstabelecimento) references estabelecimento(id)
);

create table `cpu` (
	id char(36) primary key,
    qtdNucleos int not null,
    freq double not null,
    modelo varchar(45) not null,
    fabricante varchar(45) not null,
    fkMaquina char(36) not null,
    foreign key (fkMaquina) references maquina(id)
);

create table memoria (
	id char(36) primary key,
	capacidade double not null,
    freq double not null,
    tipo varchar(5),
    fkMaquina char(36) not null,
    foreign key (fkMaquina) references maquina(id)
);

create table disco (
	id char(36) primary key,
    capacidade double not null,
    fkMaquina char(36) not null,
    foreign key (fkMaquina) references maquina(id)
);

create table rede (
	id char(36) primary key,
    ipv4 varbinary(16) not null,
    ipv6 varbinary(16) not null
);

create table interfacesRede (
	fkMaquina char(36) not null,
    fkRede char(36) not null,
    foreign key (fkMaquina) references maquina(id),
    foreign key (fkRede) references rede(id)
);

create table metrica (
	id char(36) primary key,
    usoCpu double not null,
    usoRam double not null,
    usoDisco double not null,
    dtMetrica datetime not null,
    fkMaquina char(36) not null,
    foreign key (fkMaquina) references maquina(id)
);

create table alerta (
	id char(36) primary key,
	nivel varchar(10) not null,
    descricao varchar(90) not null,
    fkMetrica char(36) not null,	constraint chkNivel check (nivel in ('aviso', 'critico')),
    foreign key (fkMetrica) references metrica(id)
);