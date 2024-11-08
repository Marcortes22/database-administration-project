using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.ReportesServices
{
    public interface ISvTareasReportes
    {
        Task<BaseResponse<List<VwEmpleadosTareasCompletada>>> GetAllCompletas();
        Task<BaseResponse<List<VwResumenTareasPorEstado>>> GetAllPorEstado();
        Task<BaseResponse<List<VwEmpleadosTareasPendiente>>> GetAllPendientesPorEmpleado();
        Task<BaseResponse<List<VwDistribucionTareasPorTipoYempleado>>> GetAllPorTipo_y_Empleado();
        Task<BaseResponse<List<VwPorcentajeTareasCompletadasPorTipo>>> GetAllPorcentajePorTipo();
       
    }
}
