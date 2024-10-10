using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.TipoHabitacionService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.TipoHabitacionService
{
    public class SvTipoHabitacion : ISvTipoHabitacion
    {

        private ZooMaContext myDbContext;

        public SvTipoHabitacion(ZooMaContext context)
        {
            myDbContext = context;
        }
        public async Task<bool> Create(tipoHabitacionCreateDto tipoHabitacion)
        {
            var nombreTipoHabitacion = new SqlParameter("@NombreTH", tipoHabitacion.NombreTH);
            try
            {
                // Ejecutamos el procedimiento almacenado
                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_INGRESAR_TIPOHABITACION @NombreTH",
                     nombreTipoHabitacion
                 );
                Console.WriteLine(result);
                return true;
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return false;
            }
        }

        public async Task<bool> Delete(int id)
        {
            var IdTipoHabitacion = new SqlParameter("@IdTipoHabitacion", id);
            try
            {
                // Ejecutamos el procedimiento almacenado
                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_ELIMINAR_TIPOHABITACION @IdTipoHabitacion",
                     IdTipoHabitacion
                 );
                Console.WriteLine(result);
                if(result == -1)
                {
                    return false;
                }
                return true;
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return false;
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

        public async Task<bool> Update(int id, tipoHabitacionUpdateDto tipoHabitacion)
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

                return true;
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return false;
            }
        }


    }
}
