using Entities;
using Services.DietaService.Dto;
using Services.EstadoTareaServices.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EstadoTareaServices
{
    public interface ISvEstadoTarea
    {
        Task<BaseResponse<List<VwEstadoTarea>>> GetAll();
        Task<BaseResponse<VwEstadoTarea>> GetById(int id);
        Task<BaseResponse<EstadoTarea>> Create(EstadoTareaCreateDto estadoTareaCreateDto, int cedulaCreador);
        Task<BaseResponse<EstadoTarea>> Update(int id, EstadoTareaUpdateDto estadoTareaUpdateDto, int cedulaCreador);
        Task<BaseResponse<EstadoTarea>> Delete(int id, int cedulaCreador);
    }
}
