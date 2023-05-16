CREATE TYPE tVenta AS TABLE(
	productName VARCHAR(64),
	lotId INT,
	amount INT
)

CREATE TYPE tVentaConId AS TABLE(
	productId int,
	lotId INT,
	amount INT
)

DROP PROCEDURE IF EXISTS  DBO.SP_AgregarSale
go
-----------------------------------------------------------
-- Author: Joctan Porras Esquivel
-- Fecha: 2023-05-15
-- Desc: Primera creacion del stored procedure que se encarga
--       de registrar ventas
-----------------------------------------------------------
CREATE PROCEDURE [dbo].[SP_AgregarSale]
	@venta tVenta READONLY,
	@buyerName varchar(64),
	@buyerLastName varchar(64),
	@buyerPhone varchar(15),
	@employeeName varchar(64),
	@employeeLastName varchar(64)
AS 
BEGIN
	
	SET NOCOUNT ON -- no retorne metadatos
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT, @CustomError2 INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT

	-- declaracion de otras variables
	DECLARE @contacInfoId int = (select ContacInfo.contacInfoId FROM ContacInfo
								 WHERE ContacInfo.name = @employeeName AND
								       ContacInfo.lastname = @employeeLastName )
	DECLARE @ventaConId tVentaConId
	INSERT INTO @ventaConId(productId, amount,lotId)
					  SELECT (select newProductId FROM NewProducts
					  WHERE name = productName), amount, lotId
					  FROM @venta

	-- Declarar variables necesarias
	DECLARE @variable1 INT
	DECLARE @variable2 INT
			
	-- Declarar el cursor
	DECLARE cursor_cantidades CURSOR FOR
	SELECT  amount, lotId
	FROM @ventaConId
	

	-- operaciones de select que no tengan que ser bloqueadas
	-- tratar de hacer todo lo posible antes de q inice la transaccion
	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 53001
		SET @CustomError = 53002

		-- put your code here
		IF @buyerLastName IS NOT NULL AND @buyerName IS NOT NULL
		   AND @contacInfoId IS NOT NULL
		   BEGIN
				
				
				INSERT INTO Sales(buyerName, buyerLastName, buyerPhone,
								  contacInfoId, postime,deleted) VALUES
							(@buyerName,@buyerLastName,@buyerPhone,
							 @contacInfoId, GETDATE(),0)

				INSERT INTO SalesXNewProducts(newProductId, amount, deleted, saleId)
							SELECT productId, amount, 0, SCOPE_IDENTITY() FROM @ventaConId
				OPEN cursor_cantidades

				-- Recuperar el primer registro del cursor
				FETCH NEXT FROM cursor_cantidades INTO @variable1, @variable2

				-- Iniciar el bucle de procesamiento de los registros del cursor
				WHILE @@FETCH_STATUS = 0
				BEGIN
					-- Lógica de procesamiento del registro actual
					UPDATE Lots
					SET productQuantity = Lots.productQuantity - @variable1
					WHERE Lots.lotId = @variable2
					

					-- Recuperar el siguiente registro del cursor
					FETCH NEXT FROM cursor_cantidades INTO @variable1, @variable2
				END

				-- Cerrar el cursor
				CLOSE cursor_cantidades
				

				IF EXISTS(SELECT productQuantity FROM Lots WHERE productQuantity < 0)
					BEGIN
						RAISERROR('%s - Error Number: %i', 
						17, 17, 'Se está intentando vender un producto sin existencias', @CustomError2)
					END
			END
		ELSE
			BEGIN	
				RAISERROR('%s - Error Number: %i', 
						17, 11, 'Se está intentando insertar un valor NULL en un campo requerido', @CustomError)
			END

		
		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
END
RETURN 0
GO


DECLARE @ventita tVenta

INSERT INTO @ventita(productName, amount,lotId) VALUES
					('Cuaderno',15,1),
					('Cuaderno',2,1),
					('Cuaderno',4,1)

exec dbo.SP_AgregarSale @ventita,'Miguel','Ternera','1234-5964', 'José','Martínez'


DELETE FROM SalesXNewProducts

DELETE FROM SalesXNewProducts
DELETE FROM Sales
DBCC CHECKIDENT (Sales, RESEED,0)
UPDATE Lots
SET productQuantity = 50000






select * from Sales

select * from SalesXNewProducts

Select * from Lots


