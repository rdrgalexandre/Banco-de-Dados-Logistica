--Script from database creation using the Microsoft SQL Server Management Studio by Rodrigo Alexandre (Apenas anotações do que foi visto no curso "implementando banco de dados" da Fundação Bradesco).

CREATE DATABASE Logistica
ON
	( 
		NAME = Logistica_DAT,
		FILENAME = 'C:\BDLogistica\Logistica_Dados.mdf',
		SIZE = 10,
		MAXSIZE = 50,
		FILEGROWTH = 5
	)

LOG ON
	( 
		NAME = Logistica_LOG,
		FILENAME = 'C:\BDLogistica\Logistica_log.ldf',
		SIZE = 5MB,
		MAXSIZE = 25MB,
		FILEGROWTH = 5MB 
	);
GO

--After database created, I'll insert the tables.

CREATE TABLE TableClientes
	(
		CodigoDoCliente	CHAR(10)	NOT NULL,
		NomeDaEmpresa	VARCHAR(70)	NOT NULL,
		NomeDoContato	VARCHAR(70)	NOT NULL,
		CargoDoContato	VARCHAR(40)	NOT NULL,
		Endereco	VARCHAR(50)	NULL,	
		Cidade VARCHAR(25)	NULL,
		Regiao VARCHAR(25)	NULL,
		CEP	CHAR(15)	NULL,
		Pais	VARCHAR(25)	NULL,
		telefone	CHAR(20)	NULL,
		Fax	CHAR(20)	NULL,
		PRIMARY KEY (CodigoDoCliente)
	);

--I created a table using the syntax above, but actually isn't the better way. I realized that worked, but I could created a table in the wrong place, I guess to have selected the database and opened the query that's put the table in the place I wanted. So, thinking in this I will create tables only using the syntax below.

USE Logistica;
GO
CREATE TABLE TableTransportadora
	(
		CodigoDaTransportadora	INT	PRIMARY KEY	NOT NULL,
		NomeDaEmpresa	VARCHAR(30)	NOT NULL,
		Telefone CHAR(20)	NULL
	)

--After created this table, I saved as "Qry_Cria_TableTransportadora" in the Logistica's database file.

USE Logistica;
GO
CREATE TABLE TableCategorias
	(
		CodigoDaCategoria	INT	PRIMARY KEY	NOT NULL,
		NomeDaCategoria	VARCHAR(30)	NOT NULL,
		Descricao	VARCHAR(100)	NULL
	)


USE Logistica;
GO
CREATE TABLE TableDetalhesDoPedido
	(
		NumeroDoPedido	INT	NOT NULL,
		CodigoDoProduto	INT	NOT NULL,
		PrecoUnitario	MONEY	NULL,
		Quantidade	INT	NULL,
		Desconto	FLOAT	NULL
		PRIMARY KEY	(NumeroDoPedido, CodigoDoProduto)
	)

--In the above table I needed to declare two primary key values, but I didn't could declare when I was writing the field (show me error). So, I tried to write as in the first syntax and worked well. 

USE Logistica;
GO
CREATE TABLE TableFornecedores
	(
		CodigoDoFornecedor	INT	NOT NULL,
		NomeDaEmpresa	VARCHAR(70)	NOT NULL,
		NomeDoContato	VARCHAR(70)	NOT NULL,
		CargoDoContato	VARCHAR(40)	NULL,
		Endereco	VARCHAR(50)	NULL,
		Cidade	VARCHAR(25)	NULL,
		Regiao	VARCHAR(25)	NULL,
		CEP	CHAR(15)	NULL,
		Pais	VARCHAR(25)	NULL,
		Telefone	CHAR(20)	NULL,
		Fax	CHAR(20)	NULL
		PRIMARY KEY (CodigoDoFornecedor)
	)


USE Logistica;
GO
CREATE TABLE TableFuncionarios
	(
		CodigoDoFuncionario	INT	NOT NULL,
		Sobrenome	VARCHAR(30)	NULL,
		Nome	VARCHAR(30)	NOT NULL,
		Cargo	VARCHAR(40)	NULL,
		Tratamento	CHAR(10)	NULL,
		DataDeNascimento	DATE	NULL,
		DataDeContratacao	DATE	NULL,
		Endereco	VARCHAR(50)	NULL,
		Cidade	VARCHAR(25)	NULL,
		Regiao	VARCHAR(25)	NULL,
		CEP	CHAR(15)	NULL,
		Pais	VARCHAR(25)	NULL,
		TelefoneResidencial	CHAR(20)	NULL,
		Ramal	CHAR(5)	NULL,
		Observacoes	VARCHAR(200)	NULL
		PRIMARY KEY (CodigoDoFuncionario)
	)

USE Logistica;
GO
CREATE TABLE TablePedidos
	(
		NumeroDoPedido	INT	NOT NULL,
		CodigoDoCliente	CHAR(10)	NOT NULL,
		CodigoDoFuncionario	INT	NOT NULL,
		DataDoPedido	DATE	NULL,
		DataDaEntrega	DATE	NULL,
		DataDeEnvio	DATE	NULL,
		CodigoDaTransportadora	INT	NOT NULL,
		Frete	MONEY	NULL,
		NomeDoDestinatario	VARCHAR(50)	NULL,
		EnderecoDoDestinatario	VARCHAR(50)	NULL,
		CEPdeDestino	CHAR(15)	NULL,
		PaisDeDestino	VARCHAR(25)	NULL,
		CidadeDeDestino	VARCHAR(25)	NULL,
		RegiaoDeDestino	VARCHAR(24)	NULL
		PRIMARY KEY (NumeroDoPedido)
	)

USE Logistica;
GO
CREATE TABLE TableProdutos
	(
		CodigoDoProduto	INT	NOT NULL,
		NomeDoProduto	VARCHAR(50)	NOT NULL,
		CodigoDoFornecedor	INT	NOT NULL,
		CodigoDaCategoria	INT	NOT NULL,
		QuantidadePorUnidade	CHAR(30)	NULL,
		PrecoUnitario	MONEY	NULL,
		UnidadeEmEstoque	INT	NULL,
		UnidadesPedidas	INT	NULL,	
		NivelDeReposicao	INT	NULL,
		Descontinuado	INT	NULL
		PRIMARY KEY (CodigoDoProduto)
	)

--*Always remember to save the tables in the database file following the same sentence used before

--After all the tables were created, I did some foreign key relationships. And now it's time to insert some data in the tables. 

USE Logistica;
GO

INSERT INTO TableClientes (CodigoDoCliente, NomeDaEmpresa, NomeDoContato, CargoDoContato, Cidade, Pais)
VALUES ('DEPLE', 'Deep Purple', 'Ian Gillan', 'Rep. comercial', 'Osasco', 'Brasil');

INSERT INTO TableClientes (CodigoDoCliente, NomeDaEmpresa, NomeDoContato, CargoDoContato, Cidade, Pais)
VALUES ('ACDC', 'ACDC', 'Angus Mckinnon Young', 'Proprietario', 'Sao Paulo', 'Brasil');

INSERT INTO TableClientes (CodigoDoCliente, NomeDaEmpresa, NomeDoContato, CargoDoContato, Cidade, Pais)
VALUES ('QUEENB', 'Queen', 'Freddie Mercury', 'Priprietario', 'Londres', 'Reino Unido');

--And in this moment were inserted some data in the TableCliente using the "Insert" syntax. Right now I'll use the syntax "Select" to show all data we inserted before. 

USE Logistica;
GO

SELECT * FROM TableClientes

--Here I'll use the syntax "Where" to refine my search.

USE Logistica;
GO

SELECT * FROM TableClientes
	WHERE Pais = 'Brasil';


--And the "Update" syntax too, doing the changes and after selecting to verify.

USE Logistica;
GO

UPDATE TableClientes
SET CodigoDoCliente = 'KING'
WHERE CodigoDoCliente = 'QUEENB'

SELECT * FROM TableClientes
WHERE CodigoDoCliente = 'KING'

--And finally the syntax "Delete".

USE Logistica;
GO

INSERT INTO TableClientes
	(
		CodigoDoCliente,
		NomeDaEmpresa,
		NomeDoContato,
		CargoDoContato,
		Endereco,
		Cidade,
		Regiao,
		CEP,
		Pais,
		telefone,
		Fax
	)
VALUES
	(
		'WTSNK',
		'United Artists Records',
		'David Coverdale',
		'Gerente de Marketing',
		'Gerente de Marketing',
		'Londres',
		'Westlake Clark',
		'OH 45344',
		'Reino Unido',
		'+44 843 538 0298',
		'+44 121 240 5844'
	);

SELECT * FROM TableClientes
WHERE CodigoDoCliente = 'WTSNK'

--After insert these informations, I'll delete.

USE Logistica;
GO

DELETE FROM TableClientes
WHERE CodigoDoCliente = 'WTSNK'

--And verify

USE Logistica;
GO

SELECT * FROM  TableClientes

--Now, I'll use "Where" with combinations, like: where between, where in, where not, where like.


