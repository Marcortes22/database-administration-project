using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.AlimentoReportesService;

namespace ZooManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AlimentoReportesController : ControllerBase
    {
        private readonly ISvAlimentoReporte _svAlimentoReporte;

        public AlimentoReportesController(ISvAlimentoReporte svAlimentoReporte)
        {
            _svAlimentoReporte = svAlimentoReporte;
        }

        [HttpGet("AlimentosPorDieta")]
        public async Task<IActionResult> GetAllAlimentosPorDieta()
        {
            var response = await _svAlimentoReporte.GetAllAlimentosPorDieta();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("AlimentosMasUtilizados")]
        public async Task<IActionResult> GetAllAlimentosMasUtilizados()
        {
            var response = await _svAlimentoReporte.GetAllAlimentosMasUtilizados();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("PromedioAlimentosPorDieta")]
        public async Task<IActionResult> GetAllPromedioAlimentosPorDieta()
        {
            var response = await _svAlimentoReporte.GetAllPremedioAlimentosPorDieta();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }


    }
}
