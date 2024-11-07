using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.VentasReportesService
{
    public class SvVentaReportes: ISvVentasReportes
    {
        private readonly ZooMaContext myDbContext;

        public SvVentaReportes(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }

        public async Task<BaseResponse<List<VwTotalEntradasVendida>>> GetAllEntradasVendidas()
        {
            try
            {
                var data = myDbContext.VwTotalEntradasVendidas.OrderByDescending(x => x.TotalEntradasVendidas).ToList();

                return new BaseResponse<List<VwTotalEntradasVendida>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTotalEntradasVendida>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwTotalVenta>>> GetAllTotalVentas()
        {
            try
            {
                var data = myDbContext.VwTotalVentas.ToList();

                return new BaseResponse<List<VwTotalVenta>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTotalVenta>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwVentasPorDium>>> GetAllVentasPorDia()
        {
            try
            {
                var data = myDbContext.VwVentasPorDia.OrderByDescending(x=>x.Fecha).ToList();

                return new BaseResponse<List<VwVentasPorDium>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwVentasPorDium>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwVentasPorEmpleado>>> GetAllVentasPorEmpleado()
        {
            try
            {
                var data = myDbContext.VwVentasPorEmpleados.OrderByDescending(x => x.MontoTotalVentas).ToList();

                return new BaseResponse<List<VwVentasPorEmpleado>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwVentasPorEmpleado>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwVentasPorEntradaYtipo>>> GetAllVentasPorEntradaYtipo()
        {
            try
            {
                var data = myDbContext.VwVentasPorEntradaYtipos.OrderByDescending(x => x.MontoTotal).ToList();

                return new BaseResponse<List<VwVentasPorEntradaYtipo>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwVentasPorEntradaYtipo>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwVentasPorMetodoPago>>> GetAllVentasPorMetodoPago()
        {
            try
            {
                var data = myDbContext.VwVentasPorMetodoPagos.OrderByDescending(x => x.MontoTotalVentas).ToList();

                return new BaseResponse<List<VwVentasPorMetodoPago>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwVentasPorMetodoPago>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwVentasPorTipoEntradum>>> GetAllVentasPorTipoEntrada()
        {
            try
            {
                var data = myDbContext.VwVentasPorTipoEntrada.OrderByDescending(x => x.MontoTotalVentas).ToList();

                return new BaseResponse<List<VwVentasPorTipoEntradum>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwVentasPorTipoEntradum>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwVentasPorVisitante>>> GetAllVentasPorVisitante()
        {
            try
            {
                var data = myDbContext.VwVentasPorVisitantes.OrderByDescending(x => x.GastoTotal).ToList();

                return new BaseResponse<List<VwVentasPorVisitante>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwVentasPorVisitante>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwTopDiasConMasVenta>>> GetTop10DiasConMasVentas()
        {
            try
            {
                var data = myDbContext.VwTopDiasConMasVentas.OrderByDescending(x => x.Fecha).ToList();

                return new BaseResponse<List<VwTopDiasConMasVenta>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTopDiasConMasVenta>>(default, false, err.Message);
            }
        }
    }
}
