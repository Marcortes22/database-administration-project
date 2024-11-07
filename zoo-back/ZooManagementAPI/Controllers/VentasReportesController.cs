using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.VentasReportesService;

namespace ZooManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VentasReportesController : ControllerBase
    {
        private readonly ISvVentasReportes _svVentasReportes;

        public VentasReportesController(ISvVentasReportes svVentasReportes)
        {
            _svVentasReportes = svVentasReportes;
        }

        [HttpGet("TotalVentas")]
        public async Task<IActionResult> GetAllTotalVentas()
        {
            var response = await _svVentasReportes.GetAllTotalVentas();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("VentasPorDia")]
        public async Task<IActionResult> GetAllVentasPorDia()
        {
            var response = await _svVentasReportes.GetAllVentasPorDia();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("VentasPorEmpleado")]
        public async Task<IActionResult> GetAllVentasPorEmpleado()
        {
            var response = await _svVentasReportes.GetAllVentasPorEmpleado();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("VentasPorMetodoPago")]

        public async Task<IActionResult> GetAllVentasPorMetodoPago()
        {
            var response = await _svVentasReportes.GetAllVentasPorMetodoPago();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("VentasPorVisitante")]
        public async Task<IActionResult> GetAllVentasPorVisitante()
        {
            var response = await _svVentasReportes.GetAllVentasPorVisitante();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("Top10DiasConMasVentas")]
        public async Task<IActionResult> GetTop10DiasConMasVentas()
        {
            var response = await _svVentasReportes.GetTop10DiasConMasVentas();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("EntradasVendidas")]
        public async Task<IActionResult> GetAllEntradasVendidas()
        {
            var response = await _svVentasReportes.GetAllEntradasVendidas();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("VentasPorTipoEntrada")]
        public async Task<IActionResult> GetAllVentasPorTipoEntrada()
        {
            var response = await _svVentasReportes.GetAllVentasPorTipoEntrada();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("VentasPorEntradaYtipo")]
        public async Task<IActionResult> GetAllVentasPorEntradaYtipo()
        {
            var response = await _svVentasReportes.GetAllVentasPorEntradaYtipo();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }





    }
}
