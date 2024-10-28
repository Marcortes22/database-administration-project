using Entities;
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
    public interface ISvAuth
    {
        Task<BaseResponse<Empleado>> Create(RegisterDto registerDto, int cedulaCreador);

        Task<BaseResponse<EmpleadoInfoDto>> Login(LoginDto loginDto);
    }
}
