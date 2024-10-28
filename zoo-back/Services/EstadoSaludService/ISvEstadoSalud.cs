using Entities;
using Services.EstadoSaludService.Dto;
using Services.genericResponse;
using Services.PuestoService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EstadoSaludService
{
    public interface ISvEstadoSalud
    {
        Task<BaseResponse<List<VwEstadoSalud>>> GetAll();
        Task<BaseResponse<VwEstadoSalud>> GetById(int id);
        Task<BaseResponse<EstadoSalud>> Create(EstadoSaludCreateDto estadoSaludCreateDto, int cedulaCreador);
        Task<BaseResponse<EstadoSalud>> Update(int id, EstadoSaludUpdateDto estadoSaludUpdateDto, int cedulaCreador);
        Task<BaseResponse<EstadoSalud>> Delete(int id, int cedulaCreador);
    }
}
