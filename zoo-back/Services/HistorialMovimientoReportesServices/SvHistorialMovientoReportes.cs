using Entities;
using Services.genericResponse;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services.HistorialMovimientoReportes
{
    public class SvHistorialMovientoReportes : ISvHistorialMovimientosReportes
    {
        private readonly ZooMaContext myDbContext;

        public SvHistorialMovientoReportes(ZooMaContext myDbContext)
        {
            this.myDbContext = myDbContext;
        }

        public async Task<BaseResponse<List<VwHistorialMovimientosPorAnimal>>> GetAllHistorialMovimientos()
        {
            try
            {
                var data = myDbContext.VwHistorialMovimientosPorAnimals.OrderByDescending(x => x.Fecha).ToList();

                return new BaseResponse<List<VwHistorialMovimientosPorAnimal>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwHistorialMovimientosPorAnimal>>(default, false, err.Message);
            }
        }

        public async Task<BaseResponse<List<VwAnimalesConMasMovimiento>>> GetAllHistorialMovimientosPorAnimal()
        {
            try
            {
                var data = myDbContext.VwAnimalesConMasMovimientos.OrderByDescending(x => x.TotalMovimientos).ToList();

                return new BaseResponse<List<VwAnimalesConMasMovimiento>>(data, true, "");
            }
            catch (Exception err)
            {
                return new BaseResponse<List<VwAnimalesConMasMovimiento>>(default, false, err.Message);
            }
        }
    }
}
