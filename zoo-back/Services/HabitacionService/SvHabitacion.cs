using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.TipoHabitacionService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.HabitacionService
{
    public class SvTipoHabitacion : ISvHabitacion
    {

        private ZooMaContext myDbContext;

        public SvTipoHabitacion(ZooMaContext context)
        {
            myDbContext = context;
        }
        public async Task<BaseResponse<TipoHabitacion>> Create(tipoHabitacionCreateDto tipoHabitacion)
        {
            var nombreTipoHabitacion = new SqlParameter("@NombreTH", tipoHabitacion.NombreTH);
            try
            {
                // Ejecutamos el procedimiento almacenado
                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_INGRESAR_TIPOHABITACION @NombreTH",
                     nombreTipoHabitacion
                 );


                return new BaseResponse<TipoHabitacion>(default, true, "Tipo habitación creado exitosamente");
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                  return new BaseResponse<TipoHabitacion>(default, false, ex.Message); 
            }
        }

        public async Task<BaseResponse<TipoHabitacion>> Delete(int id)
        {
            var IdTipoHabitacion = new SqlParameter("@IdTipoHabitacion", id);
            try
            {
                // Ejecutamos el procedimiento almacenado
                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_ELIMINAR_TIPOHABITACION @IdTipoHabitacion",
                     IdTipoHabitacion
                 );
                return new BaseResponse<TipoHabitacion>(default, true, "Tipo habitación eliminada exitosamente");
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return new BaseResponse<TipoHabitacion>(default, false, ex.Message);
            }
        }

        public async Task<List<TipoHabitacion>> GetAll()
        {
            throw new NotImplementedException();
        }

        public async Task<TipoHabitacion> GetById(int id)
        {
            throw new NotImplementedException();
        }

        public async Task<BaseResponse<TipoHabitacion>> Update(int id, tipoHabitacionUpdateDto tipoHabitacion)
        {
            var IdTipoHabitacion = new SqlParameter("@IdTipoHabitacion", id);
            var nombreTipoHabitacion = new SqlParameter("@NombreTH", tipoHabitacion.NombreTH);
            try
            {
                // Ejecutamos el procedimiento almacenado
                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_TIPOHABITACION @IdTipoHabitacion, @NombreTH",
                    nombreTipoHabitacion, IdTipoHabitacion
                );
                Console.WriteLine(result);

                return new BaseResponse<TipoHabitacion>(default, true, "Tipo habitación actualizada exitosamente");
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return new BaseResponse<TipoHabitacion>(default, false, ex.Message);
            }
        }


    }
}
