using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Entities;
using Services.EmpleadoService.Dto;
using Services.genericResponse;
using Services.TipoHabitacionService.Dto;

namespace Services.EmpleadoService
{
    public interface ISvEmpleado
    {
        Task<BaseResponse<List<VwEmpleado>>> GetAll();
        Task<BaseResponse<Empleado>> GetById(int id);
        Task<BaseResponse<Empleado>> Create(EmpleadoCreateDto CreateEmpleado);
        Task<BaseResponse<Empleado>> Update(int id, EmpleadoUpdateDto UpdateEmpleado);
        Task<BaseResponse<Empleado>> Delete(int id);
    }
}
