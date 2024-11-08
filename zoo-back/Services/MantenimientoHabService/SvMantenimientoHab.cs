using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.MantenimientoHabService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.MantenimientoHabService
{
    public class SvMantenimientoHab : ISvMantenimientoHab
    {
        private readonly ZooMaContext myDbContext;

        public SvMantenimientoHab(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }

        public async Task<BaseResponse<MantenimientoHabitacion>> newMantenimientoHabTask(CreateMantenimientoHab createMantenimientoHab, int cedulaCreador)
        {
            try
            {
                var @IdEmpleado = new SqlParameter("@IdEmpleado", createMantenimientoHab.IdEmpleado);
                var IdHabitacion = new SqlParameter("@IdHabitacion", createMantenimientoHab.IdHabitacion);
                var Nombre = new SqlParameter("@Nombre", createMantenimientoHab.NombreTarea);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_AGREGAR_TAREA_MANTENIMIENTO_HABITACION @IdEmpleado,@IdHabitacion,@Nombre ,@Cedula ",
                    IdEmpleado, IdHabitacion, Nombre, cedula
                );

                return new BaseResponse<MantenimientoHabitacion>(default, true, "Tarea creada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<MantenimientoHabitacion>(default, false, err.Message);
            }
        }
    }
}
