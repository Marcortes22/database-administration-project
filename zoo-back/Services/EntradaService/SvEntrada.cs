using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.EntradaService.Dto;
using Services.genericResponse;
using Services.TipoHabitacionService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EntradaService
{
    public class SvEntrada : ISvEntrada
    {
        private ZooMaContext myDbContext;

        public SvEntrada(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<Entradum>> Create(EntradaCreateDto entradaCreateDto, int cedulaCreador)
        {
            try
            {
                var fechaVencimiento = new SqlParameter("@fechaVencimiento", entradaCreateDto.FechaVencimiento);
                var descuento = new SqlParameter("@descuento", entradaCreateDto.Descuento);
                var IdTipoEntrada = new SqlParameter("@IdTipoEntrada", entradaCreateDto.IdTipoEntrada);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);


                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_INGRESAR_ENTRADA @fechaVencimiento,@descuento, @IdTipoEntrada, @Cedula",
                     fechaVencimiento,descuento, IdTipoEntrada, cedula
                 );


                return new BaseResponse<Entradum>(default, true, "Entrada creada exitosamente");
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return new BaseResponse<Entradum>(default, false, ex.Message);
            }
        }

        public async Task<BaseResponse<Entradum>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdEntrada = new SqlParameter("@IdEntrada", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_ELIMINAR_Entrada @IdEntrada, @Cedula",
                     IdEntrada, cedula
                 );
                return new BaseResponse<Entradum>(default, true, "Entrada eliminada exitosamente");
            }
            catch (Exception ex)
            {

                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return new BaseResponse<Entradum>(default, false, ex.Message);
            }
        }

        public async Task<BaseResponse<List<VwEntradasActiva>>> GetAll()
        {
            try
            {

                var data = await myDbContext.VwEntradasActivas.ToListAsync();

                return new BaseResponse<List<VwEntradasActiva>>(data, true, "");


            }
            catch (Exception ex)
            {

                return new BaseResponse<List<VwEntradasActiva>>(default, false, ex.Message);
            }
        }

        public async Task<BaseResponse<VwEntradasActiva>> GetById(int id)
        {
            try
            {


                var data = myDbContext.VwEntradasActivas.FirstOrDefault(x => x.IdEntrada == id);
        

                return new BaseResponse<VwEntradasActiva>(data, true, "Acción completada!");

            }
            catch (Exception ex)
            {


                return new BaseResponse<VwEntradasActiva>(default, false, ex.Message);
            }
        }

        public async Task<BaseResponse<Entradum>> Update(int id, EntradaUpdateDto entradaUpdateDto, int cedulaCreador)
        {
            var IdTipoHabitacion = new SqlParameter("@IdTipoHabitacion", id);
            try
            {
                var IdEntrada = new SqlParameter("@IdEntrada", id);
                var fechaVencimiento = new SqlParameter("@fechaVencimiento", entradaUpdateDto.FechaVencimiento);
                var descuento = new SqlParameter("@descuento", entradaUpdateDto.Descuento);
                var IdTipoEntrada = new SqlParameter("@IdTipoEntrada", entradaUpdateDto.IdTipoEntrada);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_ENTRADA @IdEntrada, @fechaVencimiento,@descuento, @IdTipoEntrada, @Cedula",
                     IdEntrada, fechaVencimiento, descuento, IdTipoEntrada, cedula
                );


                return new BaseResponse<Entradum>(default, true, "Entrada actualizada exitosamente");
            }
            catch (Exception ex)
            {

                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return new BaseResponse<Entradum>(default, false, ex.Message);
            }
        }
    }
}
