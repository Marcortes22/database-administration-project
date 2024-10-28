using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.HabitacionService;
using Services.PuestoService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.PuestoService
{
    public class SvPuesto : ISvPuesto
    {
        private ZooMaContext myDbContext;

        public SvPuesto(ZooMaContext dbContext)
        {
            myDbContext = dbContext;
        }
        public async Task<BaseResponse<Puesto>> Create(PuestoCreateDto puestoCreateDto, int cedulaCreador)
        {
            try
            {
                var nombre = new SqlParameter("@Nombre", puestoCreateDto.Nombre);
                var salario = new SqlParameter("@Salario", puestoCreateDto.Salario);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_PUESTO @Nombre, @Salario,@Cedula ",
                    nombre, salario, cedula
                );

                return new BaseResponse<Puesto>(default, true, "Puesto creado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Puesto>(default, false, err.Message);
            }
            throw new NotImplementedException();
        }

        public async Task<BaseResponse<Puesto>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdPuesto = new SqlParameter("@IdPuesto", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_PUESTO @IdPuesto, @Cedula",
                    IdPuesto, cedula
                );

                return new BaseResponse<Puesto>(default, true, "Puesto eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<Puesto>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwPuesto>>> GetAll()
        {
            try
            {
                var data = await myDbContext.VwPuestos.ToListAsync();
                
                return new BaseResponse<List<VwPuesto>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwPuesto>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Puesto>> GetById(int id)
        {
            try
            {

                var IdPuesto = new SqlParameter("@IdPuesto", id);

                var data = myDbContext.Puestos.FromSqlRaw("EXEC SP_BUSCAR_PUESTO_POR_ID @IdPuesto", IdPuesto).AsEnumerable()
               .FirstOrDefault();

                return new BaseResponse<Puesto>(data, true, "Acción completada!");
            }
            catch (Exception err)
            {
                return new BaseResponse<Puesto>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Puesto>> Update(int id, PuestoUpdateDto puestoUpdateDto, int cedulaCreador)
        {
            try
            {
                var IdPuesto = new SqlParameter("@IdPuesto", id);
                var nombre = new SqlParameter("@Nombre", puestoUpdateDto.Nombre);
                var salario = new SqlParameter("@Salario", puestoUpdateDto.Salario);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);
 


                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_PUESTO @IdPuesto, @Nombre,@Salario,@Cedula",
                    IdPuesto, nombre, salario, cedula
                );

                return new BaseResponse<Puesto>(default, true, "Puesto actualizado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Puesto>(default, false, err.Message);
            }
        }
    }
}
