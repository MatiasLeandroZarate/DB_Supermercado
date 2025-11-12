/**********************************************************************************************
  FUNCIÓN: fn_NivelMonto
  OBJETIVO:
    Clasificar cualquier monto (ventas, compras, sueldos, stock, etc.) en un rango descriptivo.
  PARÁMETRO:
    @Monto DECIMAL(18,2)
  DEVUELVE:
    NVARCHAR(10) → 'BAJO', 'MEDIO' o 'ALTO'
**********************************************************************************************/

CREATE FUNCTION fn_NivelMonto (@Monto DECIMAL(18,2))
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @Nivel NVARCHAR(10);

    IF @Monto < 10000 
        SET @Nivel = 'BAJO';
    ELSE IF @Monto BETWEEN 10000 AND 50000 
        SET @Nivel = 'MEDIO';
    ELSE 
        SET @Nivel = 'ALTO';

    RETURN @Nivel;
END;
GO
