using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.MantenimientoHabService;
using Services.MantenimientoHabService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class MantenimientoHabitacionController : ControllerBase
    {
        private readonly ISvMantenimientoHab _mantenimientoHabService;

        public MantenimientoHabitacionController(ISvMantenimientoHab mantenimientoHabService)
        {
            _mantenimientoHabService = mantenimientoHabService;
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost]

        public async Task<IActionResult> Create([FromBody] CreateMantenimientoHab createMantenimientoHab)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await _mantenimientoHabService.newMantenimientoHabTask(createMantenimientoHab, userId);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }
    }
}
