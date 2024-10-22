using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.HabitacionService;
using Services.ZooService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.ZooService
{
    public class SvZoo : ISvZoo
    {

        private ZooMaContext myDbContext;

        public SvZoo(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<Zoo>> Create(ZooCreateDto zooCreateDto, int cedulaCreador)
        {
            try
            {
                var NombreZoo = new SqlParameter("@NombreZoo", zooCreateDto.NombreZoo);
                var Direccion = new SqlParameter("@Direccion", zooCreateDto.Direccion);
                var DescripcionZoo = new SqlParameter("@DescripcionZoo", zooCreateDto.DescripcionZoo);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                   "EXEC SP_INGRESAR_ZOO @NombreZoo, @Direccion,@DescripcionZoo,@Cedula  ",
                   NombreZoo, Direccion, DescripcionZoo, cedula
               );

                return new BaseResponse<Zoo>(default, true, "Zoo creado exitosamente");
            }
            catch(Exception e)
            {
                return new BaseResponse<Zoo>(default, false,e.Message);
            }
        }

        public async Task<BaseResponse<Zoo>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdZoo = new SqlParameter("@IdZoo", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_ZOO @IdZoo, @Cedula",
                    IdZoo, cedula
                );

                return new BaseResponse<Zoo>(default, true, "Zoo eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<Zoo>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Zoo>> GetById(int id)
        {
            try
            {

                var IdZoo = new SqlParameter("@IdZoo", id);

                var data = myDbContext.Zoos.FromSqlRaw("EXEC SP_BUSCAR_ZOO_POR_ID @IdZoo", IdZoo).AsEnumerable()
               .FirstOrDefault();

                return new BaseResponse<Zoo>(data, true, "Acción completada!");
            }
            catch (Exception err)
            {
                return new BaseResponse<Zoo>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Zoo>> Update(int id, ZooUpdateDto zooUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdZoo = new SqlParameter("@IdZoo", id);
                var NombreZoo = new SqlParameter("@NombreZoo", zooUpdateDto.NombreZoo);
                var Direccion = new SqlParameter("@Direccion", zooUpdateDto.Direccion);
                var DescripcionZoo = new SqlParameter("@DescripcionZoo", zooUpdateDto.DescripcionZoo);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                   "EXEC SP_ACTUALIZAR_Zoo @IdZoo, @NombreZoo,@Direccion, @DescripcionZoo, @Cedula ",
                   IdZoo, NombreZoo, Direccion, DescripcionZoo, cedula
               );

                return new BaseResponse<Zoo>(default, true, "Zoo editado exitosamente");
            }
            catch (Exception e)
            {
                return new BaseResponse<Zoo>(default, false, e.Message);
            }
        }
    }
}
