using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.EspecieServices.Dto;
using Services.genericResponse;
using Services.PuestoService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EspecieServices
{
    public class SvEspecie : ISvEspecie
    {

        private readonly ZooMaContext myDbContext;

        public SvEspecie(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }

        public async Task<BaseResponse<Especie>> Create(EspecieCreateDto especieCreateDto, int cedulaCreador)
        {
            try
            {
                var NombreEsp = new SqlParameter("@NombreEsp", especieCreateDto.NombreEsp);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_ESPECIE @NombreEsp,@Cedula ",
                    NombreEsp, cedula
                );

                return new BaseResponse<Especie>(default, true, "Especie creada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Especie>(default, false, err.Message);
            }
           
        }

        public async Task<BaseResponse<Especie>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdEspecie = new SqlParameter("@IdEspecie", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_Especie @IdEspecie, @Cedula",
                    IdEspecie, cedula
                );

                return new BaseResponse<Especie>(default, true, "Puesto eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<Especie>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwEspecy>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwEspecies.ToListAsync();

                return new BaseResponse<List<VwEspecy>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwEspecy>>(default, false, err.Message);
            }
        }
    

        public async Task<BaseResponse<VwEspecy>> GetById(int id)
        {
            try
            {
                var data = await myDbContext.VwEspecies.FirstOrDefaultAsync(x => x.IdEspecie == id);

                return new BaseResponse<VwEspecy>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwEspecy>(default, false, err.Message);
            }
        }

        public  async Task<BaseResponse<Especie>> Update(int id, EspecieUpdateDto EspecieUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdEspecie = new SqlParameter("@IdEspecie", id);
                var NombreEsp = new SqlParameter("@NombreEsp", EspecieUpdateDto.NombreEsp);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_Especie @IdEspecie, @NombreEsp,@Cedula ",
                   IdEspecie, NombreEsp, cedula
                );

                return new BaseResponse<Especie>(default, true, "Especie creada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Especie>(default, false, err.Message);
            }
        }
    }
}
