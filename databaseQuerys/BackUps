--Parte 16: Back Ups
USE ZooMA
GO

DECLARE @backupFileName VARCHAR(250);
SET @backupFileName = 'C:\SQL-Backup\ZooMAFULL_' + CONVERT(NVARCHAR(20), GETDATE(), 112) + '_' + REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 103), ':', '') + '.bak';

BACKUP DATABASE [ZooMA] 
TO DISK = @backupFileName 
WITH DESCRIPTION = N'BACKUP FULL', 
NOFORMAT, NOINIT, 
NAME = N'ZooMA-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO

USE ZooMA;
GO
DECLARE @backupFileName NVARCHAR(250);
SET @backupFileName = 'C:\SQL-Backup\ZooMADF_' + CONVERT(NVARCHAR(20), GETDATE(), 112) + '_' + REPLACE(CONVERT(NVARCHAR(8), GETDATE(), 103), ':', '') + '.bak';

BACKUP DATABASE [ZooMA] TO 
DISK = @backupFileName WITH  
DIFFERENTIAL,  DESCRIPTION = N'BackUp Diferencial',
NOFORMAT, NOINIT,  NAME = N'ZooMA-Diferencial Database Backup',
SKIP, NOREWIND, NOUNLOAD,  STATS = 10;
GO

/*Automatizado por jods: Esta seccion esta Comentada por el motivo que se no sabemos si quien lo 
ejecute tenga activo el SQL SERVER AGENT en caso de que no puede generar error*/

/*
USE msdb;
GO
DECLARE @IdJobFull UNIQUEIDENTIFIER;
DECLARE @NombreJOBFull VARCHAR(128) = N'Backup_Full_Job';
DECLARE @DescripcionFull VARCHAR(MAX) = N'Este job realiza el backup completo cada 24 horas a partir de medianoche';
DECLARE @ComandoFullBK VARCHAR(MAX);
SET @ComandoFullBK = N'
USE ZooMA;
DECLARE @backupFileName VARCHAR(250);
SET @backupFileName = ''C:\SQL-Backup\ZooMA_'' + CONVERT(NVARCHAR(20), GETDATE(), 112) + ''_'' + REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), '':'', '''') + ''.bak'';
BACKUP DATABASE [ZooMA] TO DISK = @backupFileName WITH DESCRIPTION = N''BACK UP FULL'', NOFORMAT, NOINIT, NAME = N''ZooMA-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD, STATS = 10;
';

EXEC dbo.sp_add_job
    @job_name = @NombreJOBFull,
    @enabled = 1,
    @description = @DescripcionFull,
    @job_id = @IdJobFull OUTPUT;

EXEC dbo.sp_add_jobstep
    @job_id = @IdJobFull,
    @step_name = N'Backup Full',
    @subsystem = N'TSQL',
    @command = @ComandoFullBK,
    @retry_attempts = 3,
    @retry_interval = 5,
    @on_success_action = 1;

DECLARE @IDTareaFull INT;
EXEC dbo.sp_add_jobschedule
    @job_id = @IdJobFull,
    @name = N'Diario_a_Medianoche',
    @freq_type = 4, 
    @freq_interval = 1,
    @active_start_time = 0, 
    @schedule_id = @IDTareaFull OUTPUT;

EXEC dbo.sp_attach_schedule
    @job_id = @IdJobFull,
    @schedule_id = @IDTareaFull;

EXEC dbo.sp_update_job
    @job_id = @IdJobFull,
    @enabled = 1;

PRINT 'Backup completo, job creado y programado con éxito.';
GO

USE msdb;
GO
DECLARE @IdJob UNIQUEIDENTIFIER;
DECLARE @NombreJOB VARCHAR(128) = N'Backup_Diferencial_Job';
DECLARE @Descripcion VARCHAR(MAX) = N'Este job realiza el backup diferencial cada 24 horas a partir de medianoche';
DECLARE @ComandoDiferencialBK VARCHAR(MAX);
SET @ComandoDiferencialBK = N'
USE ZooMA;
DECLARE @backupFileName VARCHAR(250);
SET @backupFileName = ''C:\SQL-Backup\ZooMA_'' + CONVERT(VARCHAR(20), GETDATE(), 112) + ''_'' + REPLACE(CONVERT(VARCHAR(8), GETDATE(), 108), '':'', '''') + ''.bak'';
BACKUP DATABASE [ZooMA] TO DISK = @backupFileName WITH DIFFERENTIAL, DESCRIPTION = N''BackUp Diferencial'', NOFORMAT, NOINIT, NAME = N''ZooMA-Diferencial Database Backup'', SKIP, NOREWIND, NOUNLOAD, STATS = 10;
';

EXEC dbo.sp_add_job
    @job_name = @NombreJOB,
    @enabled = 1,
    @description = @Descripcion,
    @job_id = @IdJob OUTPUT;

EXEC dbo.sp_add_jobstep
    @job_id = @IdJob,
    @step_name = N'Backup Diferencial',
    @subsystem = N'TSQL',
    @command = @ComandoDiferencialBK,
    @retry_attempts = 3,
    @retry_interval = 5,
    @on_success_action = 1;

DECLARE @IDTareaDiferencial INT;
EXEC dbo.sp_add_jobschedule
    @job_id = @IdJob,
    @name = N'Diario_a_Medianoche',
    @freq_type = 4, 
    @freq_interval = 1,
    @active_start_time = 0, 
    @schedule_id = @IDTareaDiferencial OUTPUT;

EXEC dbo.sp_attach_schedule
    @job_id = @IdJob,
    @schedule_id = @IDTareaDiferencial;

EXEC dbo.sp_update_job
    @job_id = @IdJob,
    @enabled = 1;

PRINT 'Backup diferencial, job creado y programado con éxito..';
GO
*/
