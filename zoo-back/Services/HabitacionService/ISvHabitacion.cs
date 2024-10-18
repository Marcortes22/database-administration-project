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

         Task<List<Habitacion>> GetAll();
         Task<TipoHabitacion> GetById(int id);
         Task<BaseResponse<Habitacion>> Create(HabitacionCreateDto tipoHabitacion);
         Task<BaseResponse<Habitacion>> Update(int id, HabitacionUpdateDto tipoHabitacion);
         Task<BaseResponse<Habitacion>> Delete(int id);

    }
}


