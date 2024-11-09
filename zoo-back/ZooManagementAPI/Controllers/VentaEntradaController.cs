using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.VentaEntradaService;
using Services.VentaEntradaService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class VentaEntradaController : ControllerBase
    {
        private readonly ISvVentaEntrada _svVentaEntrada;

        public VentaEntradaController(ISvVentaEntrada svVentaEntrada)
        {
            _svVentaEntrada = svVentaEntrada;
        }


        [Authorize(Roles ="SELLER")]
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] VentaCreateDto ventaCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                return Ok(await _svVentaEntrada.Create(ventaCreateDto, userId));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        
            [HttpGet("ventas-sin-calificaciones")]
        public async Task<IActionResult> GetAllVentasSinCalificaciones()
        {
            var response = await _svVentaEntrada.GetAllVentasSinCalificaciones();

            if (response.Success)
            {
                return Ok(response);
            }

            return BadRequest(response);
        }





    }
}
