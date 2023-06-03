create database cinema;

/* TABELA DIRETOR */

create table if not exists `cinema`.`diretor` (
	`id_diretor` int not null,
	`nome` varchar(45) not null,
primary key (`id_diretor`));

insert into diretor values
	(01, "Andy Muschietti"),
    (02, "Louis Leterrier"),
    (03, "Lee Cronin"),
    (04, "Rob Marshall"),
    (05, "Julius Avery"),
    (06, "Chad Stahelski"),
    (07, "Aaron Horvath"),
    (08, "Darren Aronofsky"),
    (09, "James Gunn");


/* TABELA GENERO  */

create table if not exists `cinema`.`genero` (
	`id_genero` int not null,
    `nome` varchar(45) not null,
primary key (`id_genero`));

insert into genero values
	(01, "Terror"),
    (02, "Suspense"),
    (03, "Drama"),
    (04, "Fantasia"),
    (05, "Romance"),
    (06, "Ação"),
    (07, "Comédia"),
    (08, "Infantil"),
    (09, "Aventura");

/*  TABELA HORARIO  */

create table if not exists `cinema`.`horario`(
	`id_horario` int not null,
    `horario_exibicao` time not null,
primary key (`id_horario`));

insert into horario values
	(01, "10:00:00"),
    (02, "12:30:00"),
    (03, "15:00:00"),
    (04, "17:30:00"),
    (05, "19:30:00"),
    (06, "21:00:00"),
    (07, "22:00:00");

/*  TABELA SALA  */

create table if not exists `cinema`.`sala`(
	`id_sala` int not null,
    `numero` int not null,
    `capacidade` int not null,
primary key (`id_sala`));

insert into sala values
	(01, 1, 35),
    (02, 2, 41),
    (03, 3, 41),
    (04, 4, 65),
    (05, 5, 65),
    (06, 6, 65);

/*  TABELA FILME  */

create table if not exists `cinema`.`filme` (
  `id_filme` int not null,
  `nome` varchar(45) not null,
  `ano_lancamento` year not null,
  `diretor_id_diretor` int not null,
  `genero_id_genero` int not null,
  `horario_id_horario` int not null,
  `desc_filme` varchar(45) not null,
  `sala_id_sala` int not null,
  primary key (`id_filme`),
    foreign key (`diretor_id_diretor`)
    references `cinema`.`diretor` (`id_diretor`)
    on delete no action
    on update no action,
  constraint `fk_filme_genero1`
    foreign key (`genero_id_genero`)
    references `cinema`.`genero` (`id_genero`)
    on delete no action
    on update no action,
  constraint `fk_filme_horario1`
    foreign key (`horario_id_horario`)
    references `cinema`.`horario` (`id_horario`)
    on delete no action
    on update no action);
    
insert into filme values
	(01, "IT - A Coisa - Capítulo 2", 2019, 01, 01, 06, "16", 03),
    (02, "Velozes e Furiosos 10", 2023, 02, 06, 03, "12", 04),
    (03, "A Morte do Demônio - A Ascensão", 2023, 03, 01, 07, "18", 02),
    (04, "A Pequena Sereia", 2023, 04, 08, 03, "Livre", 01),
    (05, "O Exorcista do Papa", 2023, 05, 01, 05, "16", 06),
    (06, "John Wick 4: Baba Yaga", 2023, 06, 06, 05, "16", 05),
    (07, "Super Mario Bros. O Filme", 2023, 07, 04, 03, "Livre", 03),
    (08, "A Baleia", 2022, 08, 03, 03, "16", 05),
    (09, "Guardiões da Galáxia Vol. 3", 2023, 09, 09, 01, "12", 04);
    
    
/*  TABELA TELESPECTADOR  */

create table if not exists `cinema`.`telespectador`(
	`id_telespectador` int not null,
    `nome` varchar(45) not null,
    `cpf` varchar(11) not null,  
    `idade` int not null,
    `descricao` varchar(45) not null,
    `filme_id_filme` int not null,
primary key(`id_telespectador`),
foreign key (`filme_id_filme`)
    references `cinema`.`filme` (`id_filme`)
    on delete no action
    on update no action);

insert into telespectador values
(01, "Roberto", 93825342312, 23, "Pessoa Física", 08),
(02, "Jéssica", 64537652344, 33, "Pessoa Física", 03),
(03, "Janaina", 54436652314, 45, "Pessoa Jurídica", 01),
(04, "Rodrigo", 99876899085, 19, "Pessoa Física", 02),
(05, "Alberto", 42333122211, 15, "Pessoa Física", 07),
(06, "Alex", 98767587677, 16, "Pessoa Física", 07),
(07, "José", 09988943321, 21, "Cliente Especial", 06),
(08, "Amanda", 32332433444, 45, "Pessoa Física", 08),
(09, "Solange", 65554657666, 34, "Pessoa Física", 09),
(10, "Bruno", 87675665786, 30, "Pessoa Física", 09),
(11, "Gabriel", 32443542312, 24, "Pessoa Física", 05),
(12, "Henrique", 09879800097, 17, "Pessoa Física", 03),
(13, "Ricardo", 24323223212, 20, "Pessoa Física", 03),
(14, "Luiz", 66566645345, 48, "Cliente Especial", 08),
(15, "André", 645533423111, 15, "Pessoa Física", 01);


/*_______________________________________________*/

select telespectador.nome, telespectador.idade, filme.nome, filme.desc_filme
from filme join telespectador
on filme.id_filme = telespectador.filme_id_filme
where telespectador.idade < filme.desc_filme;

/*________________________________________________*/
select diretor.nome, filme.nome, filme.ano_lancamento from diretor join filme
on diretor.id_diretor = filme.diretor_id_diretor;

select sala.numero, sala.capacidade, filme.nome from sala join filme
on sala.id_sala = filme.sala_id_sala;

select genero.nome, filme.nome from genero join filme
on genero.id_genero = filme.genero_id_genero;

select horario.horario_exibicao, filme.nome from horario join filme
on horario.id_horario = filme.horario_id_horario;

select telespectador.nome, telespectador.idade, filme.nome from filme join telespectador
on filme.id_filme = telespectador.filme_id_filme;
