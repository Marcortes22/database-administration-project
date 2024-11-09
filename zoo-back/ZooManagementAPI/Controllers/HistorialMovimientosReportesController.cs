using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.HistorialMovimientoReportes;

namespace ZooManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HistorialMovimientosReportesController : ControllerBase
    {
        private readonly ISvHistorialMovimientosReportes _historialMovimientosReportes;

        public HistorialMovimientosReportesController(ISvHistorialMovimientosReportes historialMovimientosReportes)
        {
            _historialMovimientosReportes = historialMovimientosReportes;
        }

        [HttpGet("historial-movimientos")]
        public async Task<IActionResult> GetAllHistorialMovimientos()
        {
            var response = await _historialMovimientosReportes.GetAllHistorialMovimientos();

            if (response.Success)
            {
                return Ok(response);
            }

            return BadRequest(response);
        }

        [HttpGet("historial-movimientos-animal")]
        public async Task<IActionResult> GetAllHistorialMovimientosPorAnimal()
        {
            var response = await _historialMovimientosReportes.GetAllHistorialMovimientosPorAnimal();

            if (response.Success)
            {
                return Ok(response);
            }

            return BadRequest(response);
        }


    }
}
