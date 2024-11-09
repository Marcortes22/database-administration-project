--Parte 17: Logins y Usuarios
USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'ZooMAADMIN')
BEGIN
    CREATE LOGIN ZooMAADMIN WITH PASSWORD = 'Monky'
END
GO

USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'FaADMIN')
BEGIN
    CREATE LOGIN FaADMIN WITH PASSWORD = 'Max123'
END
GO

USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'MarcoADMIN')
BEGIN
    CREATE LOGIN MarcoADMIN WITH PASSWORD = 'Bruno123'
END
GO

USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'TostarADMIN')
BEGIN
    CREATE LOGIN TostarADMIN WITH PASSWORD = 'Malu123'
END
GO

USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'RobethADMIN')
BEGIN
    CREATE LOGIN RobethADMIN WITH PASSWORD = '1235'
END
GO

USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'HezronADMIN')
BEGIN
    CREATE LOGIN HezronADMIN WITH PASSWORD = '0123'
END
GO


USE master
GO
IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'empleado')
BEGIN
    CREATE LOGIN empleado WITH PASSWORD = 'EmpleadoDeberiaEstarEncriptado'
END
GO

USE ZooMa
GO
CREATE USER ZooMAADMIN FOR LOGIN ZooMAADMIN
CREATE USER empleado FOR LOGIN empleado
CREATE USER FaADMIN FOR LOGIN FaADMIN
CREATE USER MarcoADMIN FOR LOGIN MarcoADMIN
CREATE USER TostarADMIN FOR LOGIN TostarADMIN
CREATE USER RoberthADMIN FOR LOGIN RoberthADMIN
CREATE USER HezronADMIN FOR LOGIN HezronADMIN
GO
CREATE ROLE Administrador
CREATE ROLE Empleado
GO

USE ZooMa
GO
EXEC sp_addrolemember 'db_owner', 'ZooMAADMIN'
EXEC sp_addrolemember 'db_owner', 'FaADMIN'
EXEC sp_addrolemember 'db_owner', 'MarcoADMIN'
EXEC sp_addrolemember 'db_owner', 'TostarADMIN'
EXEC sp_addrolemember 'db_owner', 'RoberthADMIN'
EXEC sp_addrolemember 'db_owner', 'HezronADMIN'
EXEC sp_addrolemember 'empleado', 'empleado'
GO
--Parte 17: Fin Logins y Usuarios
