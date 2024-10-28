using Entities;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Services.Auth.Dto;
using Services.genericResponse;
using Services.RolService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.Auth
{
    public class SvAuth : ISvAuth
    {
        private ZooMaContext myDbContext;
        public SvAuth(ZooMaContext dbContext)
        {
            myDbContext = dbContext;
        }
        public async Task<BaseResponse<Empleado>> Create(RegisterDto registerDto, int cedulaCreador)
        {
            try
            {
                var IdEmpleado = new SqlParameter("@IdEmpleado", registerDto.IdEmpleado);
                var Nombre = new SqlParameter("@Nombre", registerDto.Nombre);
                var Apellido1 = new SqlParameter("@Apellido1", registerDto.Apellido1);
                var Apellido2 = new SqlParameter("@Apellido2", registerDto.Apellido2);
                var Correo = new SqlParameter("@Correo", registerDto.Correo);
                var IdPuesto = new SqlParameter("@IdPuesto", registerDto.IdPuesto);
                var Contraseña = new SqlParameter("@Contraseña", registerDto.Contraseña);
                var IdRol = new SqlParameter("@IdRol", registerDto.IdRol);
                var RolFechaInicio = new SqlParameter("@RolFechaInicio", registerDto.RolFechaInicio);
                var RolFechaFin = new SqlParameter("@RolFechaFin", registerDto.RolFechaFin);
                var cedula = new SqlParameter("@Cedula", cedulaCreador);
                var Estado = new SqlParameter("@Estado", 1);

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_REGISTER @IdEmpleado, @Nombre, @Apellido1, @Apellido2, @Correo, @IdPuesto, @Contraseña, @IdRol, @RolFechaInicio, @RolFechaFin, @Cedula, @Estado",
                    IdEmpleado, Nombre, Apellido1, Apellido2, Correo, IdPuesto, Contraseña, IdRol, RolFechaInicio, RolFechaFin, cedula, Estado
                );

                return new BaseResponse<Empleado>(default, true, "Empleado registrado correctamente!!");
            }
            catch (Exception err)
            {
                return new BaseResponse<Empleado>(default, false, err.Message);
            }
        }

     

        async Task<BaseResponse<EmpleadoInfoDto>> ISvAuth.Login(LoginDto loginDto)
        {
            try
            {
                var IdEmpleado = new SqlParameter("@IdEmpleado", loginDto.IdEmpleado);
                var Contraseña = new SqlParameter("@Contraseña", loginDto.Contraseña);
               

                var result = await myDbContext.Database.ExecuteSqlRawAsync(
                    "EXEC SP_LOGIN @IdEmpleado,@Contraseña",
                    IdEmpleado, Contraseña
                );

                var empleadoLoged = await myDbContext.VwEmpleadoLogins.FirstOrDefaultAsync(x=> x.IdEmpleado == loginDto.IdEmpleado);
                var empleadoRoles = await myDbContext.VwEmpleadoRolesActivos.Where(x => x.IdUsuario == loginDto.IdEmpleado).ToListAsync();

                if(empleadoLoged == null)
                {
                    return new BaseResponse<EmpleadoInfoDto>(default, false, "Usuario o contraseña incorrectos");
                }

                if( empleadoRoles == null)
                {
                    return new BaseResponse<EmpleadoInfoDto>(default, false, "El usuario no tiene roles activos, favor comunicarse con el administrador de base de datos!!");
                }

                EmpleadoInfoDto empleadoInfo = new EmpleadoInfoDto
                {
                    IdEmpleado = empleadoLoged.IdEmpleado,
                    Nombre = empleadoLoged.Nombre,
                    Apellido1 = empleadoLoged.Apellido1,
                    Apellido2 = empleadoLoged.Apellido2,
                    Correo = empleadoLoged.Correo,
                    Roles = empleadoRoles
                };

                return new BaseResponse<EmpleadoInfoDto>(empleadoInfo, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<EmpleadoInfoDto>(default, false, err.Message);
            }
        }
    }
}
