using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.HabitacionService.Dto;

namespace Services.HabitacionService
{
    public class SvHabitacion : ISvHabitacion
    {

        private ZooMaContext myDbContext;

        public SvHabitacion(ZooMaContext context)
        {
            myDbContext = context;
        }

        public async Task<BaseResponse<Habitacion>> Create(HabitacionCreateDto habitacion, int cedulaCreador)
        {
            try
            {
                var nombreHabitacion = new SqlParameter("@NombreHab", habitacion.NombreHab);
                var direcccion = new SqlParameter("@Direccion", habitacion.Direccion);
                var capacidad = new SqlParameter("@Capacidad", habitacion.Capacidad);
                var idTipoHabitacion = new SqlParameter("@IdTipoHabitacion", habitacion.IdTipoHabitacion);
                var IdEstadoHabitacion = new SqlParameter("@IdEstadoHabitacion", habitacion.IdEstadoHabitacion);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_HABITACION @NombreHab, @Direccion,@Capacidad,@IdTipoHabitacion, @IdEstadoHabitacion,@Cedula  ",
                    nombreHabitacion, direcccion, capacidad, idTipoHabitacion, IdEstadoHabitacion, cedula
                );

                return new BaseResponse<Habitacion>(default, true, "Habitación creada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Habitacion>(default, false, err.Message);
            }
            
        }

        public async Task<BaseResponse<Habitacion>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdTipoHabitacion = new SqlParameter("@IdHabitacion", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_Habitacion @IdHabitacion, @Cedula",
                    IdTipoHabitacion, cedula
                );

                return new BaseResponse<Habitacion>(default, true, "Habitación eliminada exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<Habitacion>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwHabitacion>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwHabitacions.ToListAsync();

                return new BaseResponse<List<VwHabitacion>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwHabitacion>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Habitacion>> GetById(int id)
        {
            try
            {

                var idHabitacion = new SqlParameter("@IdHabitacion", id);

                var data = myDbContext.Habitacions.FromSqlRaw("EXEC SP_BUSCAR_HABITACION_POR_ID @IdHabitacion", idHabitacion).AsEnumerable()
               .FirstOrDefault();

                return new BaseResponse<Habitacion>(data, true, "Acción completada!");
            }
            catch (Exception err)
            {
                return new BaseResponse<Habitacion>(default, false, err.Message);
            }

        }

        public async Task<BaseResponse<Habitacion>> Update(int id, HabitacionUpdateDto habitacion, int cedulaCreador)
        {
            try
            {
                var idHabitacion = new SqlParameter("@IdHabitacion", id);
                var nombreHabitacion = new SqlParameter("@NombreHab", habitacion.NombreHab);
                var direcccion = new SqlParameter("@Direccion", habitacion.Direccion);
                var capacidad = new SqlParameter("@Capacidad", habitacion.Capacidad);
                var idTipoHabitacion = new SqlParameter("@IdTipoHabitacion", habitacion.IdTipoHabitacion);
                var IdEstadoHabitacion = new SqlParameter("@IdEstadoHabitacion", habitacion.IdEstadoHabitacion);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);


                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_HABITACION @IdHabitacion, @NombreHab,@Direccion,@Capacidad,@IdTipoHabitacion,@IdEstadoHabitacion,@Cedula",
                    idHabitacion, nombreHabitacion, direcccion, capacidad, idTipoHabitacion, IdEstadoHabitacion, cedula
                );

                return new BaseResponse<Habitacion>(default, true, "Habitación actualizada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Habitacion>(default, false, err.Message);
            }
        }
    }
}