using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Services;
using Entities;
using Services.TipoHabitacionService.Dto;
using Services.genericResponse;
using Services.HabitacionService.Dto;

namespace Services.HabitacionService
{
    public interface ISvHabitacion
    {

         Task<BaseResponse<List<VwHabitacion>>> GetAll();
         Task<BaseResponse<Habitacion>> GetById(int id);
         Task<BaseResponse<Habitacion>> Create(HabitacionCreateDto habitacion, int cedulaCreador);
         Task<BaseResponse<Habitacion>> Update(int id, HabitacionUpdateDto habitacion, int cedulaCreador);
         Task<BaseResponse<Habitacion>> Delete(int id, int cedulaCreador);

    }
}


