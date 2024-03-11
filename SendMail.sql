use [video practica 2]

CREATE TABLE Empleados (
    Id INT PRIMARY KEY IDENTITY(1, 1),
    Nombre NVARCHAR(100),
    FechaNacimiento DATE,
    Salario DECIMAL(10, 2)
);

INSERT INTO Empleados (Nombre, FechaNacimiento, Salario)
VALUES
    ('John Doe', '1990-05-15', 6000.00),
    ('Jane Smith', '1985-08-20', 7500.00),
    ('Alice Johnson', '1992-03-10', 5500.00),
    ('Bob Brown', '1988-11-25', 7000.00),
    ('Eva Lee', '1995-02-18', 6200.00);


EXEC msdb.dbo.sp_configure 'show advanced options', 1
RECONFIGURE

EXEC msdb.dbo.sp_configure 'Database Mail XPs', 1
RECONFIGURE

EXEC msdb.dbo.sysmail_add_profile_sp
@profile_name = 'Empresa',
@description = 'Perfil para empresa';

EXEC msdb.dbo.sysmail_add_account_sp
	@account_name = 'MauricioDMO',
	@email_address = 'dt.net',
	@display_name = 'Mauricio',
	@mailserver_name = 'smtp.sendgrid.net',
	@port = 587,
	@username = 'apikey',
	@password = 'S',
	@enable_ssl = 1;

EXEC msdb.dbo.sysmail_add_profileaccount_sp
	@sequence_number = 1,
	@profile_name = 'Empresa',
	@account_name = 'MauricioDMO';


CREATE PROCEDURE email (@asunto nvarchar(50), @cuerpo nvarchar(max))
AS
BEGIN

EXEC msdb.dbo.sp_send_dbmail
	@profile_name = 'Empresa',
	@recipients = 'mauriciodmoprogrammer@gmail.com',
	@subject = @asunto,
	@body = @cuerpo;

END;


CREATE TRIGGER CorreoDeEliminacion on Empleados
AFTER DELETE
AS
BEGIN
	DECLARE @asunto nvarchar(50);
	DECLARE @cuerpo nvarchar(max);

	DECLARE @Id INT;
    DECLARE @Nombre NVARCHAR(100);
    DECLARE @FechaNacimiento DATE;
    DECLARE @Salario DECIMAL(10, 2);

	SELECT @Id = Id, @Nombre = Nombre, @FechaNacimiento = FechaNacimiento, @Salario = Salario FROM deleted


	SET @asunto = 'Empleado eliminado';
	SET @cuerpo = FORMATMESSAGE(
	'Se ha eliminado un empleado de la tabla empleados

	Id: %i
	Nombre: %s
	Fecha de nacimiento: %s
	Salario: %s',
	@Id,
	@Nombre,
	convert(nvarchar, @FechaNacimiento),
	convert(nvarchar, @Salario)
	);

	EXEC email @asunto, @cuerpo
END;

SELECT * FROM Empleados;

DELETE FROM Empleados WHERE Id = 3;

DROP TRIGGER CorreoDeEliminacion;
DROP TABLE Empleados;
