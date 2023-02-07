--Criação do esquema 'trabalho'
create schema trabalho;

--Criação das tabelas no esquema 'trabalho'
set search_path = 'trabalho';

create table maquina(
	cod_maquina char(6) not null,
	nome_maquina varchar(30) not null,
	setor char(3) not null,
	solicitante varchar(10) not null,
	primary key (cod_maquina)
);

create table funcao(
	cod_funcao char(5) not null,
	funcao varchar(20) not null,
	valor_hora money not null,
	primary key (cod_funcao)
);

create table mantenedor(
	cod_mantenedor varchar(5) not null,
	cod_funcao varchar(5) not null,
	nome_mantenedor varchar (30),
	primary key (cod_mantenedor),
	foreign key (cod_funcao) references funcao(cod_funcao)
	);

create table peca(
	cod_peca varchar(5) not null,
	nome_peca varchar(15) not null,
	unidade varchar(2) not null,
	valor_unitario money not null,
	primary key (cod_peca)
);

create table solicitacao(
	cod_ss smallserial not null,
	cod_maquina char(6) not null,
	defeito varchar (50) not null,
	data_abertura timestamp not null,
	primary key (cod_ss),
	foreign key (cod_maquina) references maquina(cod_maquina)
);

create table ordem(
	cod_os smallserial not null,
	aprovador varchar(10),
	data_aprovacao date,
	cod_ss smallserial not null unique,
	primary key (cod_os),
	foreign key (cod_ss) references solicitacao(cod_ss)
);

create table trabalho (
	cod_os smallserial not null,
	cod_mantenedor varchar(5) not null,
	inicio timestamp not null,
	termino timestamp,
	descricao text not null,
	primary key (cod_os, cod_mantenedor, inicio),
	foreign key (cod_mantenedor) references mantenedor(cod_mantenedor)
);

create table requisicao (
	cod_reqMat serial not null,
	cod_os smallserial not null,
	cod_peca varchar(5) not null,
	quantidade smallint not null,
	data_requisicao date,
	almoxarife varchar(10) not null,
	primary key (cod_reqMat),
	foreign key (cod_os) references ordem (cod_os),
	foreign key (cod_peca) references peca (cod_peca)
);

/*codigo auxiliar
drop table
	maquina,
	funcao,
	mantenedor,
	peca,
	solicitacao,
	ordem,
	trabalho,
	requisicao;
*/
--verificação indivudual das tabelas
select * from maquina;
select * from funcao;
select * from mantenedor;
select * from peca;
select * from solicitacao;
select * from ordem;
select * from trabalho;
select * from requisicao;

-- inserção dos dados nas tabelas
insert into maquina (cod_maquina, nome_maquina, setor, solicitante) values 
	('TOR001', 'Torno Romi', '001','Alex'),
	('TOR002', 'Torno Index', '001','Alex'),
	('TOR003', 'Torno Norton', '001','Alex'),
	('FUR001', 'Furadeira Vonder', '002','Bruno'),
	('FUR002', 'Furadeira Motomil', '002','Bruno'),
	('FRE001', 'Fresadora Heller', '003','Claudio'),
	('FRE002', 'Fresadora Clark', '003','Claudio'),
	('CEN001', 'Centro Usinagem Romi', '004','Daniel'),
	('CEN002', 'Centro Usinagem Index', '004','Daniel'),
	('CEN003', 'Centro Usinagem Heller', '004','Daniel'),
	('PRE001', 'Predio01', '001', 'Alex'),
	('PRE002', 'Predio02', '002', 'Bruno'),
	('PRE003', 'Predio03', '003', 'Claudio'),
	('PRE004', 'Predio04', '004', 'Daniel');
insert into funcao(cod_funcao, funcao, valor_hora) values
	('ELETR', 'ELETRICISTA', 20.00),
	('MECAN', 'MECANICO', 17.00),
	('ELETM', 'ELETROMECÂNICO', 18.00),
	('AUXMA', 'AUX. MANUTENÇÃO', 12.00),
	('PREDI', 'PEDREIRO', 12.00);
	
insert into mantenedor(cod_mantenedor, cod_funcao, nome_mantenedor) values
	('M0001', 'ELETR', 'Antonio'),
	('M0002', 'ELETR', 'Brito'),
	('M0003', 'MECAN', 'Cesar'),
	('M0004', 'MECAN', 'Dercio'),
	('M0005', 'ELETM', 'Eduardo'),
	('M0006', 'ELETM', 'Felipe'),
	('M0007', 'AUXMA', 'Gustavo'),
	('M0008', 'PREDI', 'Henrique');
	
insert into peca(cod_peca, nome_peca, unidade, valor_unitario) values
	('0001', 'parafuso', 'un', 0.05),
	('0002', 'porca', 'un', 0.08),
	('0003', 'rolamento', 'pc', 50.00),
	('0004', 'mancal', 'pc', 20.50),
	('0005', 'polia', 'pc', 100.00),
	('0006', 'eixo', 'pc', 150.00),
	('0007', 'correia', 'un', 20.00),
	('0008', 'fusivel', 'un', 0.50),
	('0009', 'disjuntor', 'pc', 80.00),
	('0010', 'cabo', 'mt', 0.05),
	('0011', 'prego', 'un', 0.02),
	('0012', 'tabua', 'un', 35.50),
	('0013', 'areia', 'mt', 100.00),
	('0014', 'cimento', 'un', 55.00);

insert into solicitacao (cod_ss, cod_maquina, defeito, data_abertura) values
	(00001, 'TOR001', 'não liga', '2021-06-15 13:00:00'),
	(00002, 'TOR002', 'eixo quebrado', '2021-06-09 11:00:00'),
	(00003, 'PRE001', 'buraco no piso', '2021-06-12 10:01:00'),
	(00004, 'PRE004', 'coluna trincada', '2021-06-11 16:02:00'),
	(00005, 'FRE001', 'correia arrebentou', '2021-06-15 13:45:00'),
	(00006, 'TOR003', 'maquina desarmando', '2021-06-01 05:18:00'),
	(00007, 'CEN002', 'rolamento trancado', '2021-06-12 17:15:00'),
	(00008, 'PRE002', 'fazer prateleira', '2021-06-06 07:30:00'),
	(00009, 'FUR001', 'correia derrapando', '2021-06-10 09:00:00'),
	(00010, 'CEN003', 'curto circuito', '2021-06-02 16:30:00');

insert into ordem (cod_os, aprovador, data_aprovacao, cod_ss) values
	(00001, 'Jeferson', '2021-06-15', 00002),
	(00002, 'Jeferson', '2021-06-15', 00001),
	(00003, 'Jeferson', '2021-06-15', 00004),
	(00004, 'Jeferson', '2021-06-12', 00003),
	(00005, 'Jeferson', '2021-06-12', 00007),
	(00006, 'Jeferson', '2021-06-12', 00005),
	(00007, 'Jeferson', '2021-06-10', 00006),
	(00008, 'Jeferson', '2021-06-10', 00009),
	(00009, 'Jeferson', '2021-06-15', 00010),
	(00010, 'Jeferson', '2021-06-02', 00008);
	
insert into trabalho (cod_os, cod_mantenedor, inicio, termino, descricao) values
	(00001, 'M0003', '2021-06-15 07:30:00', '2021-06-15 17:30:00', 'troca do eixo'),
	(00002, 'M0001', '2021-06-15 07:30:00', '2021-06-15 10:30:00', 'troca do fusivel'),
	(00003, 'M0008', '2021-06-15 07:30:00', '2021-06-15 17:30:00', 'conserto da coluna'),
	(00004, 'M0008', '2021-06-12 07:30:00', '2021-06-12 17:30:00', 'conserto do buraco'),
	(00005, 'M0005', '2021-06-12 07:30:00', '2021-06-12 17:30:00', 'troca do rolamento');
	
insert into requisicao (cod_reqMat, cod_os, cod_peca, quantidade, data_requisicao, almoxarife) values
	(00001, 00002, '0008', 1, '2021-06-15', 'Jonas'),
	(00002, 00004, '0013', 0.5, '2021-06-12', 'Jonas'),
	(00003, 00004, '0014', 1, '2021-06-12', 'Jonas'),
	(00004, 00005, '0003', 1, '2021-06-12', 'Jonas'),
	(00005, 00001, '0006', 1, '2021-06-15', 'Jonas');
	
--a.Revisão da tabela trabalho
select*from trabalho;

--b.co-relacionar a tabela ORDEM com a tabela TRABALHO
select ordem. *,  trabalho.*
from ordem, trabalho
where ordem.cod_os = trabalho.cod_os;

--c.co-relacionar a tabela ORDEM com a tabela REQUISICAO
select ordem. *,  requisicao.*
from ordem inner join requisicao
on ordem.cod_os = requisicao.cod_os;

--d.co-relacionar as tabelas ORDEM, TRABALHO, REQUISICAO
select ordem. *,  trabalho.*, requisicao.*
from ordem, trabalho, requisicao
where ordem.cod_os = trabalho.cod_os 
and
trabalho.cod_os = requisicao.cod_os

--e. Exibir um resumo contendo o código da ordem de serviço, defeito e nome da máquina para todas as máquinas
select maquina.nome_maquina, solicitacao.defeito, ordem.cod_os
from maquina inner join solicitacao
on maquina.cod_maquina = solicitacao.cod_maquina
inner join ordem
on solicitacao.cod_ss = ordem.cod_ss
order by maquina.nome_maquina

--f. Exibir um relatório resumido relacionando as peças e seus valores utilizadas nas manutenções.
select maquina.nome_maquina, solicitacao.defeito, ordem.cod_os, requisicao.cod_peca, peca.nome_peca, peca.valor_unitario
from maquina inner join solicitacao
on maquina.cod_maquina = solicitacao.cod_maquina
inner join ordem
on solicitacao.cod_ss = ordem.cod_ss
inner join requisicao
on ordem.cod_os = requisicao.cod_os
inner join peca
on requisicao.cod_peca = peca.cod_peca
order by maquina.nome_maquina;

--g.Demonstrar os valores das peças utilizadas, relacionadas às máquinas de código 'tor' em todas as suas manutenções
select maquina.cod_maquina, maquina.nome_maquina, solicitacao.defeito,ordem.cod_os, peca.nome_peca, peca.valor_unitario
from
maquina inner join solicitacao
on maquina.cod_maquina = solicitacao.cod_maquina
inner join ordem
on solicitacao.cod_ss = ordem.cod_ss
inner join requisicao
on ordem.cod_os = requisicao.cod_os
inner join peca
on requisicao.cod_peca = peca.cod_peca
where lower(maquina.cod_maquina) like 'tor%'
order by maquina.cod_maquina

--h. selecionar os funcionários que ganham mais de 15,00 a hora
select mantenedor.nome_mantenedor, funcao.valor_hora
from mantenedor left join funcao
on mantenedor.cod_funcao = funcao.cod_funcao
	where funcao.valor_hora in (
	select valor_hora
		from funcao
		where valor_hora >= '15.00'
	)

--i. Listar os custos totais com peças por setor
select maquina.setor, sum(peca.valor_unitario)
from maquina left join solicitacao
on maquina.cod_maquina = solicitacao.cod_maquina
join ordem
on solicitacao.cod_ss = ordem.cod_ss
join requisicao
on ordem.cod_os = requisicao.cod_os
join peca
on requisicao.cod_peca = peca.cod_peca
group by maquina.setor

--j. listar dos setores que tem 3 ou mais máquinas a quantidade de solicitacoes
select maquina.setor, count (maquina.cod_maquina) as QtMaquinas, count(solicitacao.cod_ss) as QtSolicitacoes
from maquina left join  solicitacao
on maquina.cod_maquina = solicitacao.cod_maquina
group by maquina.setor
having count(maquina.cod_maquina)>='3'

