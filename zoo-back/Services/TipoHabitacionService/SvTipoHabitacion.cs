﻿
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.TipoHabitacionService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Services.TipoHabitacionService
{
    public class SvTipoHabitacion : ISvTipoHabitacion
    {

        private ZooMaContext myDbContext;

        public SvTipoHabitacion(ZooMaContext context)
        {
            myDbContext = context;
        }
        public async Task<BaseResponse<TipoHabitacion>> Create(tipoHabitacionCreateDto tipoHabitacion)
        {
            var nombreTipoHabitacion = new SqlParameter("@NombreTH", tipoHabitacion.NombreTH);
            var cedula = new SqlParameter("@Cedula", "504420108");
            try
            {

                // Ejecutamos el procedimiento almacenado
                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_INGRESAR_TIPOHABITACION @NombreTH, @Cedula",
                     nombreTipoHabitacion, cedula
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
            var cedula = new SqlParameter("@Cedula", "504420108");
            try
            {
                // Ejecutamos el procedimiento almacenado
                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_ELIMINAR_TIPOHABITACION @IdTipoHabitacion, @Cedula",
                     IdTipoHabitacion, cedula
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

        public async Task<BaseResponse<List<TipoHabitacion>>> GetAll()
        {
            try
            {
                var data = await myDbContext.TipoHabitacion.FromSqlRaw("SELECT * FROM Vw_TipoHabitacion").ToListAsync();

           
                return new BaseResponse<List<TipoHabitacion>>(data, true, "");
            

            }
            catch (Exception ex)
            {
                // Manejo de errores
                return new BaseResponse<List<TipoHabitacion>>(default, false, ex.Message);
            }
        }

        public async Task<BaseResponse<TipoHabitacion>> GetById(int id)
        {
            try
            {
                var data =  await myDbContext.TipoHabitacion.FromSqlRaw("SELECT * FROM TipoHabitacion where IdTipoHabitacion = " + id).FirstAsync();

           
                return new BaseResponse<TipoHabitacion>(data, true, "");

            }
            catch (Exception ex)
            {
                // Manejo de errores

                return new BaseResponse<TipoHabitacion>(default, false, ex.Message);
            }

        }

        public async Task<BaseResponse<TipoHabitacion>> Update(int id, tipoHabitacionUpdateDto tipoHabitacion)
        {
            var IdTipoHabitacion = new SqlParameter("@IdTipoHabitacion", id);
            var nombreTipoHabitacion = new SqlParameter("@NombreTH", tipoHabitacion.NombreTH);
            var cedula = new SqlParameter("@Cedula", "504420108");
            try
            {
                // Ejecutamos el procedimiento almacenado
                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_TIPOHABITACION @IdTipoHabitacion, @NombreTH, @Cedula",
                    nombreTipoHabitacion, IdTipoHabitacion, cedula
                );
                

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
