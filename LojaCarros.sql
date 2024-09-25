-- Passo 1
-- Usando a linguagem SQL, iniciamos com a criação do Banco de dados;
create database Loja_de_carros_final
go

-- Passo 2
-- É necessário apontar para a IDE que será utilizado o banco de dados recém criado;
use Loja_de_carros_final
go

-- Passo 3
-- Criação das tabelas Entidades e suas respectivas Chaves Primarias e Chaves Estrangeiras;
--Criação Tabela Lojas;
create table Lojas
(
	Loja_Id int identity (1,1) primary key,
	Loja_Nome varchar (50),
	Loja_Endereco varchar (100),
	Carro_Renavam varchar (11),
	Vendedor_Cpf varchar (11)
)
select * from Lojas

-- Criação Tabela Clientes;
create table Clientes
(
	Cliente_Cpf varchar (11) primary key not null,
	Cliente_Nome varchar (50),
	Cliente_Endereco varchar (100),
	Cliente_Celular varchar (12),
	Loja_Id int foreign key references Lojas(Loja_Id)
)
select * from Clientes

-- Criação Tabela Carros;
create table Carros
(
	Renavam varchar (11) primary key not null,
	Carro_Fabricante varchar (30),
	Carro_Modelo varchar (30),
	Carro_Ano varchar (4),
	Carro_Cor varchar (30),
	Carro_Condicao varchar (8),
	Carro_Valor int,
	Data_Entrada date,
	Data_Saida date,
	Loja_Id int foreign key references Lojas(Loja_Id)
)
select * from Carros

-- Renomeando o atributo Renavam da tabela Carros;
exec sp_rename 'Carros.Renavam', 'Carro_Renavam', 'COLUMN';
select * from Carros

-- Excluindo o Atributo Condição da tabela Carros;
alter table Carros
drop column Carro_Condicao;
select * from Carros

-- Criação Tabela Vendedores;
create table Vendedores
(
	Vendedor_Cpf varchar (11) primary key not null,
	Vendedor_Nome varchar (50) not null,
	Vendedor_Endereco varchar (100) not null,
	Vendedor_Celular varchar (12) not null,
	Loja_Id int foreign key references Lojas(Loja_Id)
)
select * from Vendedores

-- Criação Tabela Comissão;
create table Comissao
(
    Comissao_Id int identity (1,1) primary key,
    Vendedor_Cpf varchar(11) foreign key references Vendedores(Vendedor_Cpf),
    Carro_Renavam varchar(11) foreign key references Carros(Carro_Renavam)
)
select * from Comissao

-- Passo 4
-- Alterando a tabela Comissão e adicionando uma coluna;
alter table Comissao
add Comissao_Venda decimal(10, 2);
select * from Comissao

-- Passo 5
-- Alterando a tabela e adicionando uma coluna necessária para a criação de chaves estrangeiras da Entidade Lojas;
alter table Lojas
add Cliente_Cpf varchar(11) 
-- Adicionando relacionamento das Entidades Lojas e Carro;
alter table Lojas
add constraint FK_Carro_Renavam foreign key (Carro_Renavam) references Carros(Carro_Renavam);
-- Adicionando relacionamento das Entidades Lojas e Clientes;
alter table Lojas
add constraint FK_Cliente_Cpf foreign key (Cliente_Cpf) references Clientes(Cliente_Cpf);
-- Adicionando relacionamento das Entidades Lojas e Vendedores;
alter table Lojas
add constraint FK_Vendedor_Cpf foreign key (Vendedor_Cpf) references Vendedores(Vendedor_Cpf)

-- Passo 6
-- Alterando a tabela e adicionando uma coluna necessária para a criação de chaves estrangeiras da Entidade Clientes;
alter table Clientes
add Carro_Renavam varchar(11);
alter table Clientes 
add constraint FK_Carro_Comprado foreign key (Carro_Renavam) references Carros(Carro_Renavam)
select * from Clientes

-- Passo 7
-- Inserindo valores na tabela Lojas;
insert into  Lojas (Loja_Nome, Loja_Endereco)
values ('T Car', 'Rua Pipipopo, 52')
insert into  Lojas (Loja_Nome, Loja_Endereco)
values ('New Car', 'Rua Lepolepo, 333')
select * from Lojas

-- Passo 8
-- Inserindo valores na tabela Carros
insert into Carros (Carro_Renavam, Carro_Fabricante, Carro_Modelo, Carro_Ano, Carro_Cor, Carro_Valor, Data_Entrada, Loja_Id)
values ('12345678999', 'Chevrolet', 'Camaro', '2024', 'Vermelho', 150000, '2024-01-01', 1),
       ('44455566677', 'Fiat', 'Uno', '2000', 'Amarelo', 10000, '2015-08-06', 1),
       ('15616513133', 'Volkswagen', 'Fox', '2013', 'Prata', 35000, '2023-10-02', 1),
       ('15641316546', 'Volkswagen', 'Golf', '2019', 'Azul', 55000, '2020-02-06', 1),
       ('97952613515', 'Honda', 'Civic', '2015', 'Preto', 45000, '2020-06-11', 1),
       ('46132156006', 'Land Rover', 'Discovery', '2022', 'Verde', 240000, '2023-07-08', 2),
       ('00051366468', 'Nissan', 'Sentra', '2022', 'Preto', 65000, '2023-11-05', 2),
       ('65484963131', 'Toyota', 'Corolla', '2024', 'Vermelho', 156000, '2024-02-08', 2),
       ('16510646561', 'Fiat', 'Argo', '2023', 'Prata', 63000, '2023-09-12', 2),
       ('06121023003', 'Chevrolet', 'Onix', '2019', 'Preto', 48000, '2022-03-25', 2)
select * from Carros

-- Passo 9
-- Inserindo valores na tabela Vendedores;
insert into Vendedores(Vendedor_Cpf, Vendedor_Nome, Vendedor_Endereco, Vendedor_Celular, Loja_Id)
values ('12345678999', 'Lucas Sales', 'Rua Galinha Pintadinha, 01', '015991234567', 1),
	   ('99912345688', 'Giovanni Grechi', 'Rua Dora Aventureira, 44', '011991234569', 2)
select * from Vendedores

-- Passo 10
-- Inserindo valores na tabela Clientes;
insert into Clientes (Cliente_Cpf, Cliente_Nome, Cliente_Endereco, Cliente_Celular, Loja_Id)
values ('36578915678', 'Karina Kaori', 'Rua Pãzoinho de mel, 22', '015365478412', 2),
	   ('56478913545', 'Andrea Sales', 'Rua da Bagunça, 77', '011563459875', 2),
	   ('26547896123', 'Ricardo Candido', 'Rua Ibicity, 333', '015469875310', 2),
	   ('63257946317', 'Guilherme Koji', 'Rua da Capivara, 89', '012987563147', 2),
	   ('12468735978', 'Glayson Rodrigues', 'Rua da Ignorancia. 00', '011964893175', 2)
select * from Clientes

-- Passo 11
-- Inserindo valores na tabela Comissão e criando um SELECT com INNER JOIN para apresentar os valores recebidos;
insert into Comissao (Vendedor_Cpf, Carro_Renavam, Comissao_Venda)
select Vendedores.Vendedor_Cpf, Carros.Carro_Renavam, Carros.Carro_Valor * 0.05 as Comissao_Venda
from Carros Carros
inner join 
Vendedores Vendedores on Vendedores.Vendedor_Cpf = '12345678999'
where 
Carros.Carro_Renavam in ('46132156006', '00051366468', '65484963131')
insert into Comissao (Vendedor_Cpf, Carro_Renavam, Comissao_Venda)
select Vendedores.Vendedor_Cpf, Carros.Carro_Renavam, Carros.Carro_Valor * 0.05 as Comissao_Venda
from Carros Carros
inner join 
Vendedores Vendedores on Vendedores.Vendedor_Cpf = '99912345688'
where 
Carros.Carro_Renavam in ('16510646561', '06121023003')
select * from Comissao

-- Passo 12
-- Acrescentando valores na tabela Carros na coluna Data_Saida especificando qual Renavam do veículo para saber a data de saída (Loja 1 não vendeu nenhum carro);
update Carros
set Data_Saida = '2023-10-25'
where Loja_Id = 2
and Carro_Renavam in ('46132156006')
update Carros
set Data_Saida = '2024-01-05'
where Loja_Id = 2
and Carro_Renavam in ('00051366468')
update Carros
set Data_Saida = '2024-03-19'
where Loja_Id = 2
and Carro_Renavam in ('65484963131')
update Carros
set Data_Saida = '2023-10-29'
where Loja_Id = 2
and Carro_Renavam in ('16510646561')
update Carros
set Data_Saida = '2023-03-16'
where Loja_Id = 2
and Carro_Renavam in ('06121023003')
select * from Carros

-- Passo 13
-- Editando a tabela Clientes fazendo que seja vinculado um Renavam ao cliente para saber qual carro ele comprou
update Clientes set Carro_Renavam = '46132156006' where Cliente_Cpf = '36578915678'
update Clientes set Carro_Renavam = '00051366468' where Cliente_Cpf = '56478913545'
update Clientes set Carro_Renavam = '65484963131' where Cliente_Cpf = '26547896123'
update Clientes set Carro_Renavam = '16510646561' where Cliente_Cpf = '63257946317'
update Clientes set Carro_Renavam = '06121023003' where Cliente_Cpf = '12468735978'
select * from Clientes

-- Passo 14
-- adicionando uma coluna na tabela Clientes;
alter table Clientes
add Carro_Comprado varchar(11);

-- Passo 15
-- Atribuindo os mesmos valores que foram adicionados em Carro_Renavam para Carro_Comprado (só para alterar o nome de Carro_Renavam para Carro_Comprado );
update Clientes
set Carro_Comprado = Carro_Renavam;

-- Passo 16
-- Excluindo o relacionamento da tabela Clientes com a tabela Carros;
alter table Clientes
drop constraint FK_Carro_Comprado;
select * from Clientes

-- Passo 17
-- Excluindo uma coluna da tabela Clientes
alter table Clientes
drop column Carro_Renavam;
select * from Clientes

-- Passo 18
-- Adicionando a relacionamento entre as Entidades Clientes e Carro, criando uma chave estrangeira na coluna Carro_Comprado
alter table Clientes
add constraint FK_Carro_Comprado foreign key (Carro_Comprado) references Carros(Carro_Renavam);

-- Passo 19
-- SELECTS
-- Criando os SELECTS à partir da tabela Lojas, utilizando Inner Join, ON, WHERE e ORDER BY;
-- selects
-- Executar um por vez
select * from Lojas
select * from Vendedores
select * from Carros
select * from Clientes
select * from Comissao
-- select de carros que estão na loja_id 1
select Lojas.Loja_Id, Lojas.Loja_Nome, Carros.Carro_Renavam, Carros.Carro_Fabricante, Carros.Carro_Modelo, Carros.Carro_Ano, Carros.Carro_Cor, Carros.Carro_Valor, Carros.Data_Entrada, Carros.Data_Saida
from Carros Carros
inner join Lojas Lojas on Carros.Loja_Id = Lojas.Loja_Id
where Lojas.Loja_Id = 1
-- select de carros que estão na loja_id 2
select Lojas.Loja_Id, Lojas.Loja_Nome, Carros.Carro_Renavam, Carros.Carro_Fabricante, Carros.Carro_Modelo, Carros.Carro_Ano, Carros.Carro_Cor, Carros.Carro_Valor, Carros.Data_Entrada, Carros.Data_Saida
from Carros Carros
inner join Lojas Lojas on Carros.Loja_Id = Lojas.Loja_Id
where Lojas.Loja_Id = 2
-- select de carros que estão na loja_id 1 e 2 ordenado por loja
select Lojas.Loja_Id, Lojas.Loja_Nome, Carros.Carro_Renavam, Carros.Carro_Fabricante, Carros.Carro_Modelo, Carros.Carro_Ano, Carros.Carro_Cor, Carros.Carro_Valor, Carros.Data_Entrada , Carros.Data_Saida
from Carros Carros
inner join Lojas Lojas on Carros.Loja_Id = Lojas.Loja_Id
where Lojas.Loja_Id in (1,2)
order by 
Lojas.Loja_Id
-- select de vendedores que estão na loja_id 1 e 2 ordenado por loja
select Lojas.Loja_Nome, Lojas.Loja_Endereco, Vendedores.Vendedor_Nome, Vendedores.Vendedor_Endereco, Vendedores.Vendedor_Endereco, Vendedores.Vendedor_Celular
from Vendedores Vendedores
inner join Lojas Lojas on Vendedores.Loja_Id = Lojas.Loja_Id
Where Lojas.Loja_Id in (1,2)
order by Lojas.Loja_Id
-- select de Clientes da loja id 1 (não aparece nada pois não há Clientes)
select Lojas.Loja_Id, Lojas.Loja_Nome, Lojas.Loja_Endereco, Clientes.Cliente_Nome, Clientes.Cliente_Cpf, Clientes.Cliente_Endereco, Clientes.Cliente_Celular
from Clientes Clientes
inner join Lojas Lojas on Clientes.Loja_Id = Lojas.Loja_Id
Where Lojas.Loja_Id = 1
-- select de Clientes loja id 2
select Lojas.Loja_Id, Lojas.Loja_Nome, Lojas.Loja_Endereco, Clientes.Cliente_Nome, Clientes.Cliente_Cpf, Clientes.Cliente_Endereco, Clientes.Cliente_Celular
from Clientes Clientes
inner join Lojas Lojas on Clientes.Loja_Id = Lojas.Loja_Id
Where Lojas.Loja_Id = 2
-- select de Clientes loja id 1 e 2
select Lojas.Loja_Id, Lojas.Loja_Nome, Lojas.Loja_Endereco, Clientes.Cliente_Nome, Clientes.Cliente_Cpf, Clientes.Cliente_Endereco, Clientes.Cliente_Celular
from Clientes Clientes
inner join Lojas Lojas on Clientes.Loja_Id = Lojas.Loja_Id
Where Lojas.Loja_Id in (1,2)
order by Lojas.Loja_Id
-- select para saber qual carro foi vendido, qual vendedor vendeu, para qual cliente, comissão do vendedor e qual loja
select Lojas.Loja_Id, Lojas.Loja_Nome, Carros.Carro_Fabricante, Carros.Carro_Modelo, Carros.Carro_Valor, Vendedores.Vendedor_Nome, Clientes.Cliente_Nome, Clientes.Carro_Comprado AS Carro_Comprado, Comissao.Comissao_Venda
from Carros
inner join 
Lojas on Carros.Loja_Id = Lojas.Loja_Id
inner join 
Clientes on Carros.Carro_Renavam = Clientes.Carro_Comprado
inner join 
Comissao on Carros.Carro_Renavam = Comissao.Carro_Renavam
inner join 
Vendedores on Comissao.Vendedor_Cpf = Vendedores.Vendedor_Cpf;