using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.HistorialMovimientoReportes
{
    public interface ISvHistorialMovimientosReportes
    {
        Task<BaseResponse<List<VwHistorialMovimientosPorAnimal>>> GetAllHistorialMovimientos();
        Task<BaseResponse<List<VwAnimalesConMasMovimiento>>> GetAllHistorialMovimientosPorAnimal();

    }
}
