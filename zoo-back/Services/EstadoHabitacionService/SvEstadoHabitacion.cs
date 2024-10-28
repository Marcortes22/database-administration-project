using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.EstadoHabitacionService.Dto;
using Services.EstadoTareaServices.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EstadoHabitacionService
{
    public class SvEstadoHabitacion : ISvEstadoHabitacion
    {

        private readonly ZooMaContext myDbContext;

        public SvEstadoHabitacion(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<EstadoHabitacion>> Create(EstadoHabitacionCreateDto estadoHabitacionCreateDto, int cedulaCreador)
        {
            try
            {
                var Estado = new SqlParameter("@Estado", estadoHabitacionCreateDto.Estado);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_ESTADOHABITACION @Estado,@Cedula ",
                    Estado, cedula
                );

                return new BaseResponse<EstadoHabitacion>(default, true, "Creado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<EstadoHabitacion>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<EstadoHabitacion>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdEstadoHabitacion = new SqlParameter("@IdEstadoHabitacion", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_ESTADOHABITACION @IdEstadoHabitacion, @Cedula",
                    IdEstadoHabitacion, cedula
                );

                return new BaseResponse<EstadoHabitacion>(default, true, "Eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<EstadoHabitacion>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwEstadoHabitacion>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwEstadoHabitacions.ToListAsync();

                return new BaseResponse<List<VwEstadoHabitacion>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwEstadoHabitacion>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<VwEstadoHabitacion>> GetById(int id)
        {
            try
            {
                var data = myDbContext.VwEstadoHabitacions.FirstOrDefault(x => x.IdEstadoHabitacion == id);

                return new BaseResponse<VwEstadoHabitacion>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwEstadoHabitacion>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<EstadoHabitacion>> Update(int id, EstadoHabitacionUpdateDto estadoHabitacionUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdEstadoHabitacion = new SqlParameter("@IdEstadoHabitacion", id);
                var Estado = new SqlParameter("@Estado", estadoHabitacionUpdateDto.Estado);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_EstadoHabitacion @IdEstadoHabitacion, @Estado,@Cedula ",
                    IdEstadoHabitacion, Estado, cedula
                );

                return new BaseResponse<EstadoHabitacion>(default, true, "Actualizado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<EstadoHabitacion>(default, false, err.Message);
            }
        }
    }
}
