using Entities;
using Services.ControlAnimalService.Dto;
using Services.genericResponse;
using Services.MantenimientoHabService.Dto;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.MantenimientoHabService
{
    public interface ISvMantenimientoHab
    {
       Task<BaseResponse<MantenimientoHabitacion>> newMantenimientoHabTask(CreateMantenimientoHab createMantenimientoHab, int cedulaCreador);
    }
}
