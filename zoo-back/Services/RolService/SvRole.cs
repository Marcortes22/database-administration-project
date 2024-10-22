using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.genericResponse;
using Services.HabitacionService;
using Services.PuestoService.Dto;
using Services.RolService.Dto;
namespace Services.RolService
{
    public class SvRole : ISvRole
    {
        private ZooMaContext myDbContext;
        public SvRole(ZooMaContext dbContext)
        {
            myDbContext = dbContext;
        }
        public async Task<BaseResponse<Rol>> Create(RoleCreateDto roleCreateDto, int cedulaCreador)
        {
            try
            {
                var nombre = new SqlParameter("@nombre", roleCreateDto.Nombre);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_INGRESAR_ROL @nombre, @Cedula  ",
                    nombre, cedula
                );

                return new BaseResponse<Rol>(default, true, "Rol creado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Rol>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<Rol>> Delete(int id, int cedulaCreador)
        {
            try
            {
                var IdRol = new SqlParameter("@IdRol", id);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ELIMINAR_Rol @IdRol, @Cedula",
                    IdRol, cedula
                );

                return new BaseResponse<Rol>(default, true, "Rol eliminado exitosamente");

            }
            catch (Exception err)
            {
                return new BaseResponse<Rol>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwRole>>> GetAll()
        {
            try
            {
               
                var data = await myDbContext.VwRoles.ToListAsync();

                return new BaseResponse<List<VwRole>>(data, true, "");

            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwRole>>(default, false, err.Message);
            }
        }

   
        public async Task<BaseResponse<Rol>> Update(int id, RoleUpdateDto roleUpdateDto, int cedulaCreador)
        {

            try
            {
                var IdRol = new SqlParameter("@IdRol", id);
                var nombre = new SqlParameter("@nombre", roleUpdateDto.Nombre);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_ACTUALIZAR_Rol @IdRol, @nombre, @Cedula  ",
                    IdRol, nombre, cedula
                );

                return new BaseResponse<Rol>(default, true, "Rol actulizado exitosamente");
            }
            catch (Exception err)
            {
                return new BaseResponse<Rol>(default, false, err.Message);
            }
        }
    }
}
