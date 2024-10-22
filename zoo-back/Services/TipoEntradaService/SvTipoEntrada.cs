using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.MetodoPagoService.Dto;
using Services.TipoEntradaService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.TipoEntradaService
{
    public class SvTipoEntrada : ISvTipoEntrada
    {

        private readonly ZooMaContext myDbContext;

        public SvTipoEntrada(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<TipoEntradum>> Create(TipoEntradaCreateDto tipoEntradaCreateDto, int cedulaCreador)
        {
            try
            {
                var NombreEnt = new SqlParameter("@NombreEnt", tipoEntradaCreateDto.Precio);
                var Precio = new SqlParameter("@Precio", tipoEntradaCreateDto.Precio);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_TIPO_ENTRADA @NombreEnt,@Precio, @Cedula ",
                    NombreEnt, Precio ,cedula
                );

                return new BaseResponse<TipoEntradum>(default, true, "Tipo entrada creada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<TipoEntradum>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<TipoEntradum>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdTipoEntrada = new SqlParameter("@IdTipoEntrada", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_TipoEntrada @IdTipoEntrada, @Cedula",
                    IdTipoEntrada, cedula
                );

                return new BaseResponse<TipoEntradum>(default, true, "Tipo entrada eliminada exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<TipoEntradum>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwTipoEntradum>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwTipoEntrada.ToListAsync();

                return new BaseResponse<List<VwTipoEntradum>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTipoEntradum>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<VwTipoEntradum>> GetById(int id)
        {
            try
            {
                var data =  myDbContext.VwTipoEntrada.FirstOrDefault(x=> x.IdTipoEntrada == id);

                return new BaseResponse<VwTipoEntradum>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<VwTipoEntradum>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<TipoEntradum>> Update(int id, TipoEntradaUpdateDto tipoEntradaUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdTipoEntrada = new SqlParameter("@IdTipoEntrada", id);
                var nombreEnt = new SqlParameter("@nombreEnt", tipoEntradaUpdateDto.NombreEnt);
                var Precio = new SqlParameter("@Precio", tipoEntradaUpdateDto.Precio);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_TipoEntrada @IdTipoEntrada,@nombreEnt,@Precio, @Cedula ",
                    IdTipoEntrada,nombreEnt, Precio, cedula
                );

                return new BaseResponse<TipoEntradum>(default, true, "Tipo entrada creada exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<TipoEntradum>(default, false, err.Message);
            }
        }
    }
}
