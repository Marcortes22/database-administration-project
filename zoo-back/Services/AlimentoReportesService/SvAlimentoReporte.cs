using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.AlimentoReportesService
{
    public class SvAlimentoReporte : ISvAlimentoReporte
    {

        private readonly ZooMaContext myDbContext;

        public SvAlimentoReporte(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }
        public async Task<BaseResponse<List<VwAlimentosMasUtilizado>>> GetAllAlimentosMasUtilizados()
        {
            try
            {
                var data = myDbContext.VwAlimentosMasUtilizados.OrderByDescending(x=> x.CantidadTotal).ToList();

                return new BaseResponse<List<VwAlimentosMasUtilizado>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwAlimentosMasUtilizado>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwTotalAlimentosPorDietum>>> GetAllAlimentosPorDieta()
        {
            try
            {
                var data = myDbContext.VwTotalAlimentosPorDieta.OrderByDescending(x => x.Dieta).ToList();

                return new BaseResponse<List<VwTotalAlimentosPorDietum>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwTotalAlimentosPorDietum>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwPromedioCantidadAlimentosPorDietum>>> GetAllPremedioAlimentosPorDieta()
        {
            try
            {
                var data = myDbContext.VwPromedioCantidadAlimentosPorDieta.OrderByDescending(x => x.PromedioCantidad).ToList();

                return new BaseResponse<List<VwPromedioCantidadAlimentosPorDietum>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwPromedioCantidadAlimentosPorDietum>>(default, false, err.Message);
            }
        }
    }
}
