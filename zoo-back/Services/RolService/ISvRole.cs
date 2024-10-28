using Entities;
using Services.genericResponse;
using Services.PuestoService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Services.RolService.Dto;

namespace Services.RolService
{
    public interface ISvRole
    {
        Task<BaseResponse<List<VwRole>>> GetAll();
        Task<BaseResponse<Rol>> Create(RoleCreateDto roleCreateDto, int cedulaCreador);
        Task<BaseResponse<Rol>> Update(int id, RoleUpdateDto roleUpdateDto, int cedulaCreador);
        Task<BaseResponse<Rol>> Delete(int id, int cedulaCreador);
    }
}
