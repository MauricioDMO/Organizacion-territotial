CREATE FUNCTION dbo.CalcularEdad
(
    @FechaNacimiento DATE
)
RETURNS INT
AS
BEGIN
    DECLARE @Edad INT
    DECLARE @Hoy DATE
    SET @Hoy = GETDATE()

    SET @Edad = YEAR(@Hoy) - YEAR(@FechaNacimiento)

    IF (MONTH(@Hoy) < MONTH(@FechaNacimiento) OR (MONTH(@Hoy) = MONTH(@FechaNacimiento) AND DAY(@Hoy) < DAY(@FechaNacimiento)))
        SET @Edad = @Edad - 1

    RETURN @Edad
END

SELECT dbo.CalcularEdad('2004-12-10')
