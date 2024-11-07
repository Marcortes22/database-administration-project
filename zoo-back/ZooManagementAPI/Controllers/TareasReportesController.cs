using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.ReportesServices;

namespace ZooManagementAPI.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TareasReportesController : ControllerBase
    {
        private readonly ISvTareasReportes _svReportes;

        public TareasReportesController(ISvTareasReportes svReportes)
        {
            _svReportes = svReportes;
        }

        [HttpGet("EmpleadosTareasTerminadas")]
        public async Task<IActionResult> GetAll()
        {
            var response = await _svReportes.GetAllCompletas();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("EmpleadosTareasPendientes")]
        public async Task<IActionResult> GetAllPendientes()
        {
            var response = await _svReportes.GetAllPendientesPorEmpleado();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("PorcentajeTareasCompletadasPorTipo")]
        public async Task<IActionResult> GetAllPorcentajePorTipo()
        {
            var response = await _svReportes.GetAllPorcentajePorTipo();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("ResumenTareasPorEstado")]
        public async Task<IActionResult> GetAllPorEstado()
        {
            var response = await _svReportes.GetAllPorEstado();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("DistribucionTareasPorTipoYempleado")]
        public async Task<IActionResult> GetAllPorTipo_y_Empleado()
        {
            var response = await _svReportes.GetAllPorTipo_y_Empleado();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }


    }
}
