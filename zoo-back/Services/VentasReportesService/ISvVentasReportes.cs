using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.VentasReportesService
{
    public interface ISvVentasReportes
    {
        Task<BaseResponse<List<VwTotalVenta>>> GetAllTotalVentas();
        Task<BaseResponse<List<VwVentasPorDium>>> GetAllVentasPorDia();
        Task<BaseResponse<List<VwVentasPorEmpleado>>> GetAllVentasPorEmpleado();
        Task<BaseResponse<List<VwVentasPorMetodoPago>>> GetAllVentasPorMetodoPago();
        Task<BaseResponse<List<VwVentasPorVisitante>>> GetAllVentasPorVisitante();
        Task<BaseResponse<List<VwTopDiasConMasVenta>>> GetTop10DiasConMasVentas();
        Task<BaseResponse<List<VwTotalEntradasVendida>>> GetAllEntradasVendidas();
        Task<BaseResponse<List<VwVentasPorTipoEntradum>>> GetAllVentasPorTipoEntrada();
        Task<BaseResponse<List<VwVentasPorEntradaYtipo>>> GetAllVentasPorEntradaYtipo();
      
    }
}
