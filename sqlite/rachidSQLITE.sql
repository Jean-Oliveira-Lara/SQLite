
-- DROP TABLE
-- APAGA AS TABELAS DO BANCO DE DADOS

drop table if exists pagamento_turma;
drop table if exists gasto_turma;
drop table if exists status_turma;
drop table if exists status;
drop table if exists participante;
drop table if exists turma;
drop table if exists pessoa;

-- TABELA: PESSOA

CREATE TABLE `pessoa` (
  `pessoa_id` int(11) NOT NULL PRIMARY KEY,
  `nome` varchar(100) NOT NULL ,
  `dt_nascimento` date NOT NULL,
  `email` varchar(100) NOT NULL UNIQUE,
  `whatsapp` varchar(100) NOT NULL UNIQUE,
  `login` varchar(100) NOT NULL UNIQUE,
  `senha` varchar(100) NOT NULL
);

-- TABELA: TURMA

CREATE TABLE `turma` (
  `turma_id` int(11) NOT NULL  ,
  `pessoa_id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `dt_criacao` datetime NOT NULL,
  `dt_encerramento` datetime NULL,
  `descricao` varchar(400) NOT NULL,
  PRIMARY KEY (`turma_id`),
  FOREIGN KEY (pessoa_id) REFERENCES pessoa(pessoa_id)
);

-- TABELA: PARTICIPANTE

CREATE TABLE `participante` (
  `turma_id` int(11) NOT NULL,
  `pessoa_id` int(11) NOT NULL,
  `dt_ingresso` datetime NOT NULL,
  `dt_saida` datetime NULL,
  PRIMARY KEY (`turma_id`,`pessoa_id`),
  FOREIGN KEY(`turma_id`)  REFERENCES turma(`turma_id`),
  FOREIGN KEY(`pessoa_id`)  REFERENCES pessoa(`pessoa_id`)
);

-- TABELA: STATUS

CREATE TABLE `status` (
  `status_id` int(11) NOT NULL PRIMARY KEY,
  `status` varchar(25) NOT NULL UNIQUE,
  `descricao` varchar(200) NULL
);

-- TABELA: STATUS_TURMA

CREATE TABLE `status_turma` (
  `turma_id` int(11) NOT NULL,
  `dt_status` datetime NOT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`turma_id`,`dt_status`),
  FOREIGN KEY (`turma_id`) REFERENCES turma(`turma_id`),
  FOREIGN KEY (`status_id`) REFERENCES status(`status_id`)
);

-- TABELA: GASTOS_TURMA

CREATE TABLE `gasto_turma` (
  `gasto_id` int(11) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `pessoa_id` int(11) NOT NULL,
  `dt_registro` datetime NOT NULL,
  `dt_gasto` datetime NOT NULL,
  `descricao` varchar(400) not null,
  PRIMARY KEY (`gasto_id`),
  FOREIGN KEY (`turma_id`, `pessoa_id`) REFERENCES participante(`turma_id`, `pessoa_id`)
);

-- TABELA: PAGAMENTO_TURMA

CREATE TABLE `pagamento_turma` (
  `pagamento_id` int(11) NOT NULL,
  `turma_id` int(11) NOT NULL,
  `pessoa_id` int(11) NOT NULL,
  `dt_registro` datetime NOT NULL,
  `valor_pago` datetime NOT NULL,
  `modo_pagamento`  varchar(100) not null,
  `descricao` varchar(400) not null,
  PRIMARY KEY (`pagamento_id`),
  FOREIGN KEY (`turma_id`, `pessoa_id`) REFERENCES participante(`turma_id`, `pessoa_id`)
);

-- INSERÇÃO INICIAL DE DADOS

insert into status (status_id, status, descricao) VALUES
(1, 'Criada', 'A turma foi criada, mas não está ainda aberta para a participação'),
(2, 'Aberta', 'A turma foi aberta para outros participantes'),
(3, 'Fechada', 'A turma não permite o ingresso de novos participantes'),
(4, 'Ativa', 'A turma está operando , mas não aceita novos participantes. Gastos e pagamentos podem ser informados'),
(5, 'Não aceita gastos', 'A turma não aceita mais registros de gastos'),
(6, 'Não aceita pagamentos', 'A turma não aceita mais registros de pagamentos'),
(7, 'Congelada', 'A turma permite consultas, mas ainda pode ser reativada'),
(8, 'Encerrada', 'A turma apenas permite consultas. Não pode ser reativada');

insert into pessoa (pessoa_id, nome, dt_nascimento, email, whatsapp, login, senha) VALUES
(1, 'Milton', '1965-02-27', 'milton.adriao@gmail.com', '41 99117-5015', 'milton', 'senha'),
(2, 'Paquito', '1965-02-27', 'paquito@gmail.com', '41 99117-5016', 'p0131', 'senha'),
(3, 'Lupita', '1965-02-27', 'lupita@gmail.com', '41 99117-5017', 'lups', 'senha'),
(4, 'Margot', '1965-02-27', 'margozinha@gmail.com', '41 99117-5018', 'margarida', 'senha'),
(5, 'Rita', '1965-02-27', 'ritoca@gmail.com', '41 99117-5019', 'ritoca', 'senha'),
(6, 'Briselda', '1965-02-27', 'brizeh@gmail.com', '41 99117-5020', 'briselda', 'senha'),
(7, 'Duda', '1965-02-27', 'duda@gmail.com', '41 99117-5021', 'duda_sin_duda', 'senha'),
(8, 'Josefina', '1965-02-27', 'josi@gmail.com', '41 99117-5022', 'josi', 'senha'),
(9, 'Felps', '1965-02-27', 'felps@gmail.com', '41 99117-5023', 'colimerio', 'senha'),
(10, 'Théia', '1965-02-27', 'theia_tetéia@gmail.com', '41 99117-5024', 'teteia', 'senha'),
(11, 'Lola', '1965-02-27', 'loloca@gmail.com', '41 99117-5025', 'lola0758', 'senha'),
(12, 'Manchinha', '1965-02-27', 'sir_spot@gmail.com', '41 99117-5026', 'aff', 'senha'),
(13, 'Costelinha', '1965-02-27', 'costelinha@gmail.com', '41 99117-5027', 'costela', 'senha'),
(14, 'Maya', '1965-02-28', 'mayushka@gmail.com', '41 99117-5028', 'maya', 'senha');

insert into turma  (turma_id, nome, pessoa_id, dt_criacao, descricao) VALUES
(1, 'Festa de São Francisco de Assis', 3, '2026-06-01', 'Festerê dia 4 de outubro de 20236, em casa mesmo porque está chovendo'),
(2, 'Festa de Oxóssi', 12, '2026-10-05', 'Comemoração no sítio');

insert into status_turma (turma_id, dt_status, status_id) VALUES
(1, '2026-06-01 10:16', 1),
(1, '2026-06-01 10:17', 2),
(1, '2026-06-04 11:18', 3),
(1, '2026-06-04 11:19', 4),
(2, '2026-10-05 06:30', 1),
(2, '2026-10-05 07:15', 2),
(2, '2026-10-06 06:30', 3);

insert into participante (turma_id, pessoa_id, dt_ingresso) VALUES
(1, 2, '2026-10-01 10:14'),
(1, 3, '2026-10-01 10:14'),
(1, 4, '2026-10-01 10:18'),
(1, 5, '2026-10-01 10:24'),
(1, 6, '2026-10-01 11:00'),
(1, 7, '2026-10-01 12:14'),
(1, 8, '2026-10-01 15:01'),
(1, 9, '2026-10-01 15:02'),
(1, 10, '2026-10-01 16:45'),
(1, 11, '2026-10-01 17:56'),
(2, 2, '2026-10-05 08:10'),
(2, 3, '2026-10-06 08:15'),
(2, 4, '2026-10-06 19:18'),
(2, 5, '2026-10-06 20:12'),
(2, 6, '2026-10-06 23:00'),
(2, 7, '2026-10-06 12:10'),
(2, 8, '2026-10-06 14:01'),
(2, 9, '2026-10-06 16:02'),
(2, 10, '2026-10-06 17:45'),
(2, 11, '2026-10-06 17:56'),
(2, 12, '2026-10-06 17:57'),
(2, 13, '2026-10-06 17:58'),
(2, 14, '2026-10-06 17:59');


