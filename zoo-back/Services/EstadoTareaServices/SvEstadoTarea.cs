using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.AlimentosService.Dto;
using Services.EstadoTareaServices.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EstadoTareaServices
{
    public class SvEstadoTarea : ISvEstadoTarea
    {

        private readonly ZooMaContext myDbContext;

        public SvEstadoTarea(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<EstadoTarea>> Create(EstadoTareaCreateDto estadoTareaCreateDto, int cedulaCreador)
        {
            try
            {
                var Nombre = new SqlParameter("@Nombre", estadoTareaCreateDto.Nombre);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_ESTADO_TAREA @Nombre,@Cedula ",
                    Nombre, cedula
                );

                return new BaseResponse<EstadoTarea>(default, true, "Estado tarea creado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<EstadoTarea>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<EstadoTarea>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdEstadoTarea = new SqlParameter("@IdEstadoTarea", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_EstadoTarea @IdEstadoTarea, @Cedula",
                    IdEstadoTarea, cedula
                );

                return new BaseResponse<EstadoTarea>(default, true, "Alimento eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<EstadoTarea>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwEstadoTarea>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwEstadoTareas.ToListAsync();

                return new BaseResponse<List<VwEstadoTarea>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwEstadoTarea>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<VwEstadoTarea>> GetById(int id)
        {
            try
            {
                var data = myDbContext.VwEstadoTareas.FirstOrDefault(x => x.IdEstadoTarea == id);

                return new BaseResponse<VwEstadoTarea>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwEstadoTarea>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<EstadoTarea>> Update(int id, EstadoTareaUpdateDto estadoTareaUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdEstadoTarea = new SqlParameter("@IdEstadoTarea", id);
                var Nombre = new SqlParameter("@Nombre", estadoTareaUpdateDto.Nombre);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_EstadoTarea @IdEstadoTarea, @Nombre,@Cedula ",
                    IdEstadoTarea, Nombre, cedula
                );

                return new BaseResponse<EstadoTarea>(default, true, "Alimento actualizado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<EstadoTarea>(default, false, err.Message);
            }
        }
    }
}
