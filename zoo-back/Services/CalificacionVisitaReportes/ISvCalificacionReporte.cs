using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.CalificacionVisitaReportes
{
    public interface ISvCalificacionReporte
    {
        Task<BaseResponse<List<VwPromedioCalificacione>>> GetAllPromedioCalificaciones();
        Task<BaseResponse<List<VwCalificacionesPorFecha>>> GetAllCalificacionesPorFecha();
        Task<BaseResponse<List<VwPromedioNotaFinalPorMe>>> GetAllPromedioCalificacionPorMes();
    }
}
