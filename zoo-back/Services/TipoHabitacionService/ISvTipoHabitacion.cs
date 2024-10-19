using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Services;
using Entities;
using Services.TipoHabitacionService.Dto;
using Services.genericResponse;

namespace Services.TipoHabitacionService
{
    public interface ISvTipoHabitacion
    {

         Task<BaseResponse<List<VwTipoHabitacion>>> GetAll();
         Task<BaseResponse<TipoHabitacion>> GetById(int id);
         Task<BaseResponse<TipoHabitacion>> Create(tipoHabitacionCreateDto tipoHabitacion);
         Task<BaseResponse<TipoHabitacion>> Update(int id, tipoHabitacionUpdateDto tipoHabitacion);
         Task<BaseResponse<TipoHabitacion>> Delete(int id);

    }
}


