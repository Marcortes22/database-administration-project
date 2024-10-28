using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.AlimentosService.Dto;
using Services.EspecieServices.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.AlimentosService
{
    public class SvAlimentos : ISvAlimentos
    {

        private readonly ZooMaContext myDbContext;

        public SvAlimentos(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<Alimento>> Create(AlimentosCreateDto alimentosCreateDto, int cedulaCreador)
        {
            try
            {
                var Nombre = new SqlParameter("@Nombre", alimentosCreateDto.Nombre);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_ALIMENTOS @Nombre,@Cedula ",
                    Nombre, cedula
                );

                return new BaseResponse<Alimento>(default, true, "Alimento creado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Alimento>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Alimento>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdAlimentos = new SqlParameter("@IdAlimentos", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_ALIMENTO @IdAlimentos, @Cedula",
                    IdAlimentos, cedula
                );

                return new BaseResponse<Alimento>(default, true, "Alimento eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<Alimento>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwAlimento>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwAlimentos.ToListAsync();

                return new BaseResponse<List<VwAlimento>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwAlimento>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<VwAlimento>> GetById(int id)
        {
            try
            {
                var data =  myDbContext.VwAlimentos.FirstOrDefault(x=>x.IdAlimentos == id);

                return new BaseResponse<VwAlimento>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwAlimento>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Alimento>> Update(int id, AlimentosUpdateDto alimentosUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdAlimentos = new SqlParameter("@IdAlimentos", id);
                var Nombre = new SqlParameter("@Nombre", alimentosUpdateDto.Nombre);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_Alimentos @IdAlimentos, @Nombre,@Cedula ",
                    IdAlimentos,Nombre, cedula
                );

                return new BaseResponse<Alimento>(default, true, "Alimento actualizado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Alimento>(default, false, err.Message);
            }
        }
    }
}
