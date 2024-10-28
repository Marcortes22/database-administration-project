using Entities;
using Services.EstadoHabitacionService.Dto;
using Services.genericResponse;
using Services.TipoTareaService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.EstadoHabitacionService
{
    public interface ISvEstadoHabitacion
    {
        Task<BaseResponse<List<VwEstadoHabitacion>>> GetAll();
        Task<BaseResponse<VwEstadoHabitacion>> GetById(int id);
        Task<BaseResponse<EstadoHabitacion>> Create(EstadoHabitacionCreateDto estadoHabitacionCreateDto, int cedulaCreador);
        Task<BaseResponse<EstadoHabitacion>> Update(int id, EstadoHabitacionUpdateDto estadoHabitacionUpdateDto, int cedulaCreador);
        Task<BaseResponse<EstadoHabitacion>> Delete(int id, int cedulaCreador);
    }
}
