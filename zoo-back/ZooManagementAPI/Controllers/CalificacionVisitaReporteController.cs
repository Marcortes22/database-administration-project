using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.CalificacionVisitaReportes;

namespace ZooManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CalificacionVisitaReporteController : ControllerBase
    {
        private readonly ISvCalificacionReporte _svCalificacionReporte;

        public CalificacionVisitaReporteController(ISvCalificacionReporte svCalificacionReporte)
        {
            _svCalificacionReporte = svCalificacionReporte;
        }

        [HttpGet("CalificacionesPorFecha")]
        public async Task<IActionResult> GetAllCalificacionesPorFecha()
        {
            var response = await _svCalificacionReporte.GetAllCalificacionesPorFecha();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("PromedioCalificaciones")]
        public async Task<IActionResult> GetAllPromedioCalificaciones()
        {
            var response = await _svCalificacionReporte.GetAllPromedioCalificaciones();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("PromedioCalificacionesPorMes")]
        public async Task<IActionResult> GetAllPromedioCalificacionPorMes()
        {
            var response = await _svCalificacionReporte.GetAllPromedioCalificacionPorMes();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }


    }
}
