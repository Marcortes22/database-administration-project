using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Services;
using Entities;
using Services.TipoHabitacionService.Dto;

namespace Services.TipoHabitacionService
{
    public interface ISvTipoHabitacion
    {

         Task<List<TipoHabitacion>> GetAll();
         Task<TipoHabitacion> GetById(int id);
         Task<bool> Create(tipoHabitacionCreateDto tipoHabitacion);
         Task<bool> Update(int id, tipoHabitacionUpdateDto tipoHabitacion);
         Task<bool> Delete(int id);

    }
}


