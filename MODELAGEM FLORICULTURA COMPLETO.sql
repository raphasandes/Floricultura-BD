Create Database Floricultura_114;

use floricultura_114;

create table Cliente(
IdCliente int primary key auto_increment,
NomeCliente varchar(30) not null,
SobrenomeCliente varchar(50) not null,
CPF varchar(20) not null,
Email varchar(70) not null);

create table LocalEntrega(
IdLocalEntrega int primary key auto_increment,
Logradouro varchar(50) not null,
Cidade varchar(30) not null,
CEP varchar(18) not null,
PontoReferencia text not null);

create table TipoProduto(
IdTipoProduto int primary key auto_increment,
TipoProduto varchar(20) not null);

create table Produto(
IdProduto int primary key auto_increment,
NomeProduto varchar(60) not null,
Marca varchar(50) not null,
Valor float not null,
Cor varchar(50) not null,
Tamanho varchar(50) not null,
Descricao text not null,
Id_TipoProduto int,
foreign key (Id_TipoProduto) references TipoProduto (IdTipoProduto) on delete cascade
);

create table Encomenda(
Id_Encomenda int primary key not null auto_increment,
CodRastreio int not null unique,
Peso float not null,
DataCompra date not null,
DataEntrega date not null,
Id_Cliente int,
Id_Produto int,
Id_LocalEntrega int,
foreign key (Id_Cliente) references Cliente (IdCliente) on delete cascade,
foreign key (Id_Produto) references Produto (IdProduto) on delete cascade,
foreign key (Id_LocalEntrega) references LocalEntrega (IdLocalEntrega) on delete cascade);


/* Criação de Procedure */

Delimiter $$
Create Procedure p_InsercaoCliente(N VARCHAR (30), SN VARCHAR (50), C VARCHAR (20), E VARCHAR (70))
begin
Insert into Cliente VALUES (Null, N, SN, C, E);
end $$
Delimiter ;

Delimiter $$
Create Procedure p_AdicionarProduto (NP VARCHAR (50), MR VARCHAR (50), VL FLOAT, C VARCHAR (50), T VARCHAR (50), D TEXT, ID_TP INT)
begin
Insert into Produto values (null, NP, MR, VL, C, T, D, ID_TP);
end $$
Delimiter ;

Delimiter $$

CREATE PROCEDURE p_ListarProdutosPorTipo(IN p_nome_tipo_produto VARCHAR(20))
BEGIN
    SELECT P.NomeProduto, P.Marca, P.Valor, P.Cor, P.Tamanho, P.Descricao, TP.TipoProduto
    FROM Produto AS P
    INNER JOIN TipoProduto AS TP ON P.Id_TipoProduto = TP.IdTipoProduto
    WHERE TP.TipoProduto = p_nome_tipo_produto;
END $$
Delimiter ;


DELIMITER $$
CREATE PROCEDURE p_HistoricoComprasCliente(IN p_id_cliente INT)
BEGIN
    SELECT E.CodRastreio, E.Peso, E.DataCompra, E.DataEntrega, P.NomeProduto, P.Valor AS ValorProduto, L.Logradouro, L.Cidade, L.CEP
    FROM Encomenda AS E
    INNER JOIN
        Cliente AS C ON E.Id_Cliente = C.IdCliente
    INNER JOIN
        Produto AS P ON E.Id_Produto = P.IdProduto
    INNER JOIN
        LocalEntrega AS L ON E.Id_LocalEntrega = L.IdLocalEntrega
    WHERE
        C.IdCliente = p_id_cliente
    ORDER BY
        E.DataCompra DESC;
END $$
DELIMITER ;


/* Inserção de dados */

Insert into TipoProduto(TipoProduto)
values
("Flores"), /*1*/
("Chocolates"), /*2*/
("Presentes"), /*3*/
("Cartão"); /*4*/


Call p_insercaoCliente ('Ana', 'Silva', '123.456.789-01', 'ana.silva@email.com'); /*1*/
Call p_insercaoCliente ('Bruno', 'Souza', '234.567.890-12', 'bruno.souza@email.com'); /*2*/
Call p_insercaoCliente ('Carla', 'Martins', '345.678.901-23', 'carla.martins@email.com'); /*3*/
Call p_insercaoCliente ('Daniel', 'Oliveira', '456.789.012-34', 'daniel.oliveira@email.com'); /*4*/
Call p_insercaoCliente ('Elisa', 'Santos', '567.890.123-45', 'elisa.santos@email.com'); /*5*/
Call p_insercaoCliente ('Felipe', 'Pereira', '678.901.234-56', 'felipe.pereira@email.com'); /*6*/
Call p_insercaoCliente ('Gabriela', 'Costa', '789.012.345-67', 'gabriela.costa@email.com'); /*7*/
Call p_insercaoCliente ('Hugo', 'Almeida', '890.123.456-78', 'hugo.almeida@email.com'); /*8*/
Call p_insercaoCliente ('Isabela', 'Rodrigues', '901.234.567-89', 'isabela.rodrigues@email.com'); /*9*/
Call p_insercaoCliente ('João', 'Fernandes', '012.345.678-90', 'joao.fernandes@email.com'); /*10*/

Call p_AdicionarProduto ('Buquê de Rosas Vermelhas', 'Floricultura Jardim Encantado', 85.50, 'Vermelho', 'Médio', 'Lindo buquê com 12 rosas vermelhas frescas, ideal para demonstrar amor e paixão.', 1); /*1*/
Call p_AdicionarProduto ('Caixa de Bombons Finos', 'Cacau Imperial', 65.90, 'Variadas', 'Único', 'Seleção de 24 bombons artesanais com recheios variados e cobertura de chocolate belga.', 2); /*2*/
Call p_AdicionarProduto ('Urso de Pelúcia Gigante', 'Sonhos de Algodão', 120.00, 'Marrom', 'Grande', 'Urso de pelúcia super macio e abraçável, perfeito para todas as idades.', 3); /*3*/
Call p_AdicionarProduto ('Cartão de Aniversário Pop-up', 'Gráfica Criativa', 15.00, 'Colorido', 'Pequeno', 'Cartão com design pop-up inovador para felicitar em aniversários.', 4); /*4*/
Call p_AdicionarProduto ('Orquídea Phalaenopsis Branca', 'Exótica Flores', 99.90, 'Branco', 'Médio', 'Elegante orquídea com flores brancas e delicadas, em vaso decorativo.', 1); /*5*/
Call p_AdicionarProduto ('Barra de Chocolate Amargo 70%', 'Choco Puro', 18.75, 'Marrom Escuro', 'Pequeno', 'Chocolate amargo intenso com 70% cacau, para os apreciadores de sabores marcantes.', 2); /*6*/
Call p_AdicionarProduto ('Kit de Vinho e Taças', 'Delícias Gourmet', 150.00, 'Vermelho/Transparente', 'Grande', 'Conjunto com uma garrafa de vinho tinto de safra especial e duas taças de cristal.', 3); /*7*/
Call p_AdicionarProduto ('Cartão de Desculpas Divertido', 'Humor & Papel', 12.50, 'Azul', 'Pequeno', 'Cartão com mensagem divertida para pedir desculpas de forma leve.', 4); /*8*/
Call p_AdicionarProduto ('Cesta de Café da Manhã', 'Amanhecer Saboroso', 180.00, 'Variadas',  'Grande', 'Cesta recheada com pães, frutas, bolos, sucos e geleias para um café especial.', 3); /*9*/
Call p_AdicionarProduto ('Girassóis Alegres', 'Floricultura Sol Nascente', 70.00, 'Amarelo',  'Médio', 'Buquê com 5 girassóis vibrantes, simbolizando alegria e energia positiva.', 1); /*10*/
Call p_AdicionarProduto ('Bombons Sortidos Gourmet', 'Doce Encanto', 55.00, 'Variadas', 'Único', 'Caixa com 16 bombons de sabores variados, ideais para presentear.', 2); /*11*/
Call p_AdicionarProduto ('Caneca Personalizada', 'Criar & Gravar', 35.00, 'Branco', 'Médio', 'Caneca de cerâmica personalizável com foto ou frase, ótima para o dia a dia.', 3); /*12*/
Call p_AdicionarProduto ('Cartão de Parabéns com Glitter', 'Brilho Festivo', 10.00, 'Rosa', 'Pequeno', 'Cartão de parabéns com detalhes em glitter, perfeito para celebrações.', 4); /*13*/
Call p_AdicionarProduto ('Mix de Rosas Coloridas', 'Cores do Jardim', 90.00, 'Variadas', 'Médio', 'Arranjo com rosas de diversas cores, criando um visual alegre e harmonioso.', 1); /*14*/
Call p_AdicionarProduto ('Trufas de Chocolate ao Leite', 'Trufa Mania', 45.00, 'Marrom Claro', 'Pequeno', 'Kit com 10 trufas de chocolate ao leite, macias e cremosas.', 2); /*15*/
Call p_AdicionarProduto ('Kit de Ferramentas Compacto', 'Mãos na Massa', 75.00, 'Preto', 'Pequeno', 'Conjunto essencial de ferramentas para pequenos reparos domésticos, em estojo prático.', 3); /*16*/

Insert into LocalEntrega (Logradouro, Cidade, CEP, PontoReferencia)
values
('QNA 30, Lote 05', 'Taguatinga', '72110-300', 'Próximo à Praça do DI'), /*1*/
('QNL 08, Conjunto A, Casa 12', 'Taguatinga', '72150-080', 'Ao lado da Escola Classe 08'), /*2*/
('QNJ 45, Bloco C, Apartamento 101', 'Taguatinga', '72140-450', 'Perto da Feira dos Goianos'), /*3*/
('QNG 05, Lote 20', 'Taguatinga', '72130-050', 'Esquina com a Avenida Hélio Prates'), /*4*/
('QNM 15, Conjunto F, Casa 03', 'Taguatinga', '72145-150', 'Atrás do Centro Comercial Norte'), /*5*/
('QNL 23, Bloco J, Apartamento 302', 'Taguatinga', '72155-230', 'Perto da Estação Praça do Relógio do Metrô'), /*6*/
('QNA 10, Lote 18', 'Taguatinga', '72110-100', 'Em frente à Igreja Matriz de Taguatinga'), /*7*/
('QNJ 01, Conjunto B, Casa 07', 'Taguatinga', '72140-010', 'Próximo ao Hospital Regional de Taguatinga (HRT)'), /*8*/
('QNG 35, Lote 02', 'Taguatinga', '72130-350', 'Ao lado do Supermercado Tatico'), /*9*/
('QNM 03, Bloco K, Apartamento 201', 'Taguatinga', '72145-030', 'Perto do Taguatinga Shopping'), /*10*/
('QNL 15, Conjunto C, Casa 09', 'Taguatinga', '72155-150', 'Próximo à Praça da CSB 02'), /*11*/
('QNA 50, Lote 01', 'Taguatinga', '72110-500', 'Perto do SESC Taguatinga Norte'); /*12*/

Insert into Encomenda (CodRastreio, Peso, DataCompra, DataEntrega, Id_Cliente, Id_Produto, Id_LocalEntrega)
values
(10012360, 0.30, "2025-07-02", "2025-07-03", 10, 11, 1), /*1*/
(10012356, 3.20, "2025-06-30", "2025-07-01", 6, 7, 3), /*2*/
(10012350, 0.90, "2025-07-04", "2025-07-04", 3, 1, 10), /*3*/
(10012353, 0.03, "2025-07-03", "2025-07-03", 8, 4, 6), /*4*/
(10012361, 0.35, "2025-06-25", "2025-06-27", 4, 12, 2), /*5*/
(10012364, 0.30, "2025-06-29", "2025-06-30", 5, 15, 8), /*6*/
(10012351, 0.90, "2025-07-04", "2025-07-04", 3, 2, 10), /*7 - Segunda compra do cliente 3*/
(10012354, 1.1, "2025-07-03", "2025-07-04", 1, 5, 4), /*8*/
(10012740, 0.9, "2025-06-02", "2025-06-03", 4, 1, 2), /*9 - Segunda compra do cliente 4; segunda compra do produto 1 */
(10012352, 2.5, "2025-07-01", "2025-07-02", 6, 3, 6), /* 10- Segunda compra client 10 */
(10012362, 0.03, "2025-06-18", "2025-06-19", 2, 13, 5), /*11*/
(10012355, 1.10, "2025-06-02", "2025-06-03", 7, 6, 9), /*12*/
(10012357, 0.20, "2025-07-01", "2025-07-01", 9, 8, 7), /*13*/
(10082379, 0.30, "2025-06-01", "2025-06-02", 4, 15, 2), /*14 - Terceira compra do cliente 4*/
(10013252, 0.03, "2025-05-28", "2025-05-28", 3, 13, 10), /*15*/
(10012365, 2.50, "2025-07-05", "2025-07-06", 1, 3, 5), /*16*/
(10012366, 0.90, "2025-07-06", "2025-07-07", 2, 1, 1), /*17*/
(10012367, 0.35, "2025-07-07", "2025-07-08", 5, 12, 7), /*18*/
(10012368, 1.80, "2025-07-08", "2025-07-09", 8, 9, 11), /*19*/
(10012369, 0.10, "2025-07-09", "2025-07-10", 10, 6, 3), /*20*/
(10012370, 1.00, "2025-07-10", "2025-07-11", 7, 14, 9), /*21*/
(10012371, 1.20, "2025-07-11", "2025-07-12", 9, 16, 12); /*22*/

/* QUERIES */

/*1) Listar todos os dados dos clientes da floricultura */
Select * from cliente;

/* 2) Listar todos os produtos cadastrados com seus respectivos tipos */
Select *, tipoproduto
from produto
inner join tipoproduto
on IdTipoProduto = Id_TipoProduto;

/* 3) Listar os cinco produtos mais caros */
select * from produto
order by valor desc
limit 5;

/* 4) Os ítens grandes devem ser transportados por caminhão, já que não cabem em mototaxi. Por favor, mostrar a lista dos produtos que não podem ser transportados por moto */
Select * from produto
where tamanho = "grande";

/* 5) Precisamos da lista dos pedidos que foram feitos durante a semana do Dia dos Namorados */
SELECT E.CodRastreio, E.DataCompra, E.DataEntrega, E.Peso, C.NomeCliente, C.SobrenomeCliente, P.NomeProduto, P.Marca, L.Logradouro AS EnderecoEntrega, L.Cidade AS CidadeEntrega
FROM Encomenda AS E
INNER JOIN
Cliente AS C ON E.Id_Cliente = C.IdCliente
INNER JOIN
Produto AS P ON E.Id_Produto = P.IdProduto
INNER JOIN
LocalEntrega AS L ON E.Id_LocalEntrega = L.IdLocalEntrega
where datacompra between '2025-06-09' AND '2025-06-15'
order by datacompra; /* Não há compras registradas para este período */

/* 6) Listar o cliente que mais compra */
SELECT C.IdCliente, C.NomeCliente, C.SobrenomeCliente, COUNT(E.Id_Encomenda) AS TotalEncomendas
FROM Cliente AS C
INNER JOIN
Encomenda AS E
ON C.IdCliente = E.Id_Cliente
GROUP BY
C.IdCliente, C.NomeCliente, C.SobrenomeCliente
ORDER BY
TotalEncomendas DESC
LIMIT 1;

/* 7) Listar todos os locais de entrega em Taguatinga */
Select * from localentrega
where Cidade = "Taguatinga";

/*8) Quais são os tipos de produtos mais vendidos? */
SELECT TP.TipoProduto, COUNT(E.Id_Encomenda) AS TotalVendas
FROM TipoProduto AS TP
INNER JOIN
Produto AS P ON TP.IdTipoProduto = P.Id_TipoProduto
INNER JOIN
Encomenda AS E ON P.IdProduto = E.Id_Produto
GROUP BY TP.IdTipoProduto, TP.TipoProduto
ORDER BY TotalVendas DESC
Limit 1;

/* 9) Qual é o produto predileto dos clientes? */
SELECT P.NomeProduto, P.Marca, COUNT(E.Id_Produto) AS TotalEncomendas
FROM Produto AS P
INNER JOIN Encomenda AS E ON P.IdProduto = E.Id_Produto
GROUP BY P.IdProduto, P.NomeProduto, P.Marca
ORDER BY TotalEncomendas DESC
LIMIT 1;

/* 10) Existem produtos de mesma marca? */
SELECT Marca, COUNT(IdProduto) AS QuantidadeProdutos
FROM Produto
GROUP BY Marca
HAVING COUNT(IdProduto) > 1; /* Não. Cada produto é de uma marca diferente */

/* 11) O cliente Hugo Almeida pediu para atualizar seu e-mail para "hugo.almeida.10@email.com" */
Update cliente
set email = "hugo.almeida.10@email.com"
where IdCliente = 8;
select * from cliente
where IdCliente = 8;

/* 12) Precisamos saber do peso total que foi liberado do estoque com as vendas */
SELECT SUM(Peso) AS PesoTotalVendas
FROM Encomenda;

/* 13) Existe alguma encomenda entregue perto do Hospital Regional de Taguatinga? */
SELECT E.CodRastreio, E.DataEntrega, C.NomeCliente, C.SobrenomeCliente, P.NomeProduto, L.Logradouro, L.Cidade, L.PontoReferencia
FROM Encomenda AS E
INNER JOIN LocalEntrega AS L
ON E.Id_LocalEntrega = L.IdLocalEntrega
INNER JOIN Cliente AS C
ON E.Id_Cliente = C.IdCliente
INNER JOIN Produto AS P ON E.Id_Produto = P.IdProduto
WHERE L.PontoReferencia LIKE '%Hospital Regional de Taguatinga%';

/*14) Precisamos dos códigos de rastreio da compra do buquê de rosas vermelhas */
SELECT E.CodRastreio, E.DataCompra, concat(C.NomeCliente, " ", C.SobrenomeCliente) as "Nome Completo", P.NomeProduto as "Produto"
FROM Encomenda AS E
INNER JOIN Produto AS P
ON E.Id_Produto = P.IdProduto
INNER JOIN Cliente AS C
ON E.Id_Cliente = C.IdCliente
WHERE P.NomeProduto = 'Buquê de Rosas Vermelhas'
ORDER BY E.DataCompra;

/* 15) Quais são os produtos que são do tipo "chocolate"? */
SELECT P.NomeProduto, P.Marca, P.Valor, P.Descricao
FROM Produto AS P
INNER JOIN TipoProduto AS TP
ON P.Id_TipoProduto = TP.IdTipoProduto
WHERE TP.TipoProduto = 'Chocolates';