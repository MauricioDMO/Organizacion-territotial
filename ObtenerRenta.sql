CREATE FUNCTION ObtenerRenta
(
    @Nombre varchar(50),
    @Sueldo decimal(10, 2),
    @TipoRenta varchar(30)
)
RETURNS @TablaResultado TABLE
(
    Nombre varchar(50),
    Sueldo decimal(10, 2),
    TipoRenta varchar(30),
	  Renta decimal(10, 2),
	  AFP decimal(10, 2),
	  Seguro  decimal(10, 2),
	  Total decimal(10, 2)
)
AS
BEGIN
  DECLARE @Descuento decimal(10, 2)
	DECLARE @AFP decimal(10, 2)
	DECLARE @Seguro decimal(10, 2)
  
  -- Porcentaje afp
	SET @AFP = @Sueldo * 0.0725
  
	-- Porcentaje seguro social
	SET @Seguro = @Sueldo * 0.07
  
  IF (@TipoRenta = 'PLANILLA')
      SET @Descuento = CASE
          WHEN @Sueldo - @Seguro - @AFP >= 2038.11 THEN (@Sueldo - @Seguro - @AFP - 2038.11) * 0.3 + 288.57 
          WHEN @Sueldo - @Seguro - @AFP >= 895.25 THEN (@Sueldo - @Seguro - @AFP - 895.24) * 0.2 + 60
          WHEN @Sueldo - @Seguro - @AFP >= 472.01 THEN (@Sueldo - @Seguro - @AFP - 472) * 0.1 + 17.67
          ELSE 0
      END;
  ELSE IF (@TipoRenta = 'SERVICIOS PROFESIONALES')
      SET @Descuento = 0.1 * @Sueldo



  INSERT INTO @TablaResultado (Nombre, Sueldo, TipoRenta, Renta, AFP, Seguro, Total)
  VALUES (@Nombre, @Sueldo, @TipoRenta, @Descuento, @AFP, @Seguro, @Sueldo - @Descuento - @AFP - @Seguro)

  RETURN
END
