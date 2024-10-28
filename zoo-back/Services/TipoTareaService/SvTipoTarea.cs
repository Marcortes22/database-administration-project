using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.EstadoTareaServices.Dto;
using Services.genericResponse;
using Services.TipoTareaService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.TipoTareaService
{
    public class SvTipoTarea : ISvTipoTarea
    {

        private readonly ZooMaContext myDbContext;

        public SvTipoTarea(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<TipoTarea>> Create(TipoTareaCreateDto tipoTareaCreateDto, int cedulaCreador)
        {
            try
            {
                var NombreTT = new SqlParameter("@NombreTT", tipoTareaCreateDto.NombreTt);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_TIPO_TAREA @NombreTT,@Cedula ",
                    NombreTT, cedula
                );

                return new BaseResponse<TipoTarea>(default, true, "Creado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<TipoTarea>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<TipoTarea>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdTipoTarea = new SqlParameter("@IdTipoTarea", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_TIPO_TAREA @IdTipoTarea, @Cedula",
                    IdTipoTarea, cedula
                );

                return new BaseResponse<TipoTarea>(default, true, "Eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<TipoTarea>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwTipoTarea>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwTipoTareas.ToListAsync();

                return new BaseResponse<List<VwTipoTarea>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTipoTarea>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<VwTipoTarea>> GetById(int id)
        {
            try
            {
                var data = myDbContext.VwTipoTareas.FirstOrDefault(x => x.IdTipoTarea == id);

                return new BaseResponse<VwTipoTarea>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwTipoTarea>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<TipoTarea>> Update(int id, TipoTareaUpdateDto tipoTareaUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdTipoTarea = new SqlParameter("@IdTipoTarea", id);
                var NombreTT = new SqlParameter("@NombreTT", tipoTareaUpdateDto.NombreTt);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_TipoTarea @IdTipoTarea, @NombreTT,@Cedula ",
                    IdTipoTarea, NombreTT, cedula
                );

                return new BaseResponse<TipoTarea>(default, true, "Actualizado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<TipoTarea>(default, false, err.Message);
            }
        }
    }
}
