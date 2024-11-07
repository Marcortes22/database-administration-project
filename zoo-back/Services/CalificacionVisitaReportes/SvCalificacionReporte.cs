using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.CalificacionVisitaReportes
{
    public class SvCalificacionReporte : ISvCalificacionReporte
    {
        private readonly ZooMaContext myDbContext;

        public SvCalificacionReporte(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }

        public async Task<BaseResponse<List<VwCalificacionesPorFecha>>> GetAllCalificacionesPorFecha()
        {
            try
            {
                var data = myDbContext.VwCalificacionesPorFechas.OrderByDescending(x => x.Fecha).ToList();

                return new BaseResponse<List<VwCalificacionesPorFecha>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwCalificacionesPorFecha>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwPromedioCalificacione>>> GetAllPromedioCalificaciones()
        {
            try
            {
                var data = myDbContext.VwPromedioCalificaciones.OrderByDescending(x => x.PromedioNotaFinal).ToList();

                return new BaseResponse<List<VwPromedioCalificacione>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwPromedioCalificacione>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwPromedioNotaFinalPorMe>>> GetAllPromedioCalificacionPorMes()
        {
            try
            {
                var data = myDbContext.VwPromedioNotaFinalPorMes.OrderByDescending(x => x.Anio)
                    .ThenByDescending(x => x.Mes).ToList();

                return new BaseResponse<List<VwPromedioNotaFinalPorMe>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwPromedioNotaFinalPorMe>>(default, false, err.Message);
            }
        }
    }
}
