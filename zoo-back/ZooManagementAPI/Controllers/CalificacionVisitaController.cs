using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.CalificacionVisitaService;
using Services.CalificacionVisitaService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class CalificacionVisitaController : ControllerBase
    {

        private readonly ISvCalificacionVisita _svCalificacionVisita;
        public CalificacionVisitaController(ISvCalificacionVisita svCalificacionVisita)
        {
            _svCalificacionVisita = svCalificacionVisita;
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] CalificacionVisitaCreateDto calificacionVisitaCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                return Ok(await _svCalificacionVisita.Create(calificacionVisitaCreateDto, userId));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }
    }
}
