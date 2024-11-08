using Entities;
using Services.CalificacionVisitaService.Dto;
using Services.EstadoTareaServices.Dto;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.CalificacionVisitaService
{
    public interface ISvCalificacionVisita
    {
        Task<BaseResponse<CalificacionVisitum>> Create(CalificacionVisitaCreateDto calificacionVisitaCreateDto, int cedulaCreador);
    }
}
