create schema if not exists financas;
create table financas.lancamento (id  bigserial not null, ano int4, data_cadastro timestamp, descricao varchar(255), mes int4, status varchar(255), tipo varchar(255), valor numeric(19, 2), id_usuario int8, primary key (id));
create table financas.usuario (id  bigserial not null, email varchar(255), nome varchar(255), senha varchar(255), primary key (id));
alter table if exists financas.lancamento add constraint FKt2a5b4jc8powehfmsyeufarkr foreign key (id_usuario) references financas.usuario;

-- add user to test
insert into financas.usuario (nome, email, senha) values ("John Doe", "teste@teste.com", "1234");
