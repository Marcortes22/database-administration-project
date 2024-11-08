using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.ReportesServices
{
    public class SvTareasReportes : ISvTareasReportes
    {
        private readonly ZooMaContext myDbContext;

        public SvTareasReportes(ZooMaContext context)
        {
            myDbContext = context;
        }
        public async Task<BaseResponse<List<VwEmpleadosTareasCompletada>>> GetAllCompletas()
        {
            try
            {
                var data = myDbContext.VwEmpleadosTareasCompletadas.OrderByDescending(x => x.TareasCompletadas).ToList();

                return new BaseResponse<List<VwEmpleadosTareasCompletada>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwEmpleadosTareasCompletada>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwEmpleadosTareasPendiente>>> GetAllPendientesPorEmpleado()
        {
            try
            {
                var data = myDbContext.VwEmpleadosTareasPendientes.ToList();

                return new BaseResponse<List<VwEmpleadosTareasPendiente>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwEmpleadosTareasPendiente>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwPorcentajeTareasCompletadasPorTipo>>> GetAllPorcentajePorTipo()
        {
            try
            {
                var data = myDbContext.VwPorcentajeTareasCompletadasPorTipos.ToList();

                return new BaseResponse<List<VwPorcentajeTareasCompletadasPorTipo>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwPorcentajeTareasCompletadasPorTipo>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwResumenTareasPorEstado>>> GetAllPorEstado()
        {
            try
            {
                var data = myDbContext.VwResumenTareasPorEstados.ToList();

                return new BaseResponse<List<VwResumenTareasPorEstado>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwResumenTareasPorEstado>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwDistribucionTareasPorTipoYempleado>>> GetAllPorTipo_y_Empleado()
        {
            try
            {
                var data = myDbContext.VwDistribucionTareasPorTipoYempleados.ToList();

                return new BaseResponse<List<VwDistribucionTareasPorTipoYempleado>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwDistribucionTareasPorTipoYempleado>>(default, false, err.Message);
            }
        }
    }
}