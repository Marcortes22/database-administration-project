using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.AlimentoReportesService
{
    public interface ISvAlimentoReporte
    {
        Task<BaseResponse<List<VwTotalAlimentosPorDietum>>> GetAllAlimentosPorDieta();
        Task<BaseResponse<List<VwAlimentosMasUtilizado>>> GetAllAlimentosMasUtilizados();
        Task<BaseResponse<List<VwPromedioCantidadAlimentosPorDietum>>> GetAllPremedioAlimentosPorDieta();
       
    }
}
