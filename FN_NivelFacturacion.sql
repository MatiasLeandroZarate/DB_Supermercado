/**********************************************************************************************
  FUNCIÓN: fn_NivelMonto
  OBJETIVO:
    Clasificar cualquier monto (ventas, compras, sueldos, stock, etc.) en un rango descriptivo.
  PARÁMETRO:
    @Monto DECIMAL(18,2)
  DEVUELVE:
    NVARCHAR(10) → 'BAJO', 'MEDIO' o 'ALTO'
**********************************************************************************************/
CREATE FUNCTION fn_NivelFacturacion (@Monto DECIMAL (10,2))
RETURNS VARCHAR (10)
AS
BEGIN
    DECLARE @Nivel VARCHAR (10);

    IF @Monto < 50000
        SET @Nivel = 'BAJO';
    ELSE IF @Monto BETWEEN 50000 AND 200000
        SET @Nivel = 'MEDIO';
    ELSE
        SET @Nivel = 'ALTO';

    RETURN @Nivel;
END;
