using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.EstadoSaludService.Dto;
using Services.genericResponse;
using Services.VentaEntradaService.Dto;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EstadoSaludService
{
    public class SvEstadoSalud : ISvEstadoSalud
    {

        private readonly ZooMaContext myDbContext;

        public SvEstadoSalud(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<EstadoSalud>> Create(EstadoSaludCreateDto estadoSaludCreateDto, int cedulaCreador)
        {
            try
            {
                var estadoSalud = new SqlParameter("@estadoSalud", estadoSaludCreateDto.EstadoSalud);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                     "EXEC SP_INGRESAR_ESTADO_SALUD @estadoSalud, @Cedula",
                     estadoSalud, cedula
                 );


                return new BaseResponse<EstadoSalud>(default, true, "Estado Salud Registrado exitosamente");
            }
            catch (Exception ex)
            {
                // Manejo de errores
                Console.WriteLine($"Error al ejecutar el procedimiento: {ex.Message}");
                return new BaseResponse<EstadoSalud>(default, false, ex.Message);
            }
        }

        public async Task<BaseResponse<EstadoSalud>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdEstadoSalud = new SqlParameter("@IdEstadoSalud", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_EstadoSalud @IdEstadoSalud, @Cedula",
                    IdEstadoSalud, cedula
                );

                return new BaseResponse<EstadoSalud>(default, true, "Puesto eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<EstadoSalud>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwEstadoSalud>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwEstadoSaluds.ToListAsync();

                return new BaseResponse<List<VwEstadoSalud>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwEstadoSalud>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<VwEstadoSalud>> GetById(int id)
        {
            try
            {
                var data = myDbContext.VwEstadoSaluds.FirstOrDefault(x=> x.IdEstadoSalud == id);

                return new BaseResponse<VwEstadoSalud>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwEstadoSalud>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<EstadoSalud>> Update(int id, EstadoSaludUpdateDto estadoSaludUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdEstadoSalud = new SqlParameter("@IdEstadoSalud", id);
                var estadoSalud = new SqlParameter("@estadoSalud", estadoSaludUpdateDto.EstadoSalud);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_EstadoSalud @IdEstadoSalud,@EstadoSalud, @Cedula",
                    IdEstadoSalud, estadoSalud, cedula
                );

                return new BaseResponse<EstadoSalud>(default, true, "Puesto eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<EstadoSalud>(default, false, err.Message);
            }
        }
    }
}
