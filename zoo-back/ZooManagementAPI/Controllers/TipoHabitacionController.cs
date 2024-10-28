using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.TipoHabitacionService;
using Services.TipoHabitacionService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TipoHabitacionController : ControllerBase
    {
        private readonly ISvTipoHabitacion _svTipoHabitacion;
        public TipoHabitacionController(ISvTipoHabitacion svTipoHabitacion)
        {
            _svTipoHabitacion = svTipoHabitacion;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {

            return Ok(await _svTipoHabitacion.GetAll());

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            try
            {

            return Ok(await _svTipoHabitacion.GetById(id));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] tipoHabitacionCreateDto tipoHabitacionCreateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

            return Ok( await _svTipoHabitacion.Create(tipoHabitacionCreateDto, userId));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] tipoHabitacionUpdateDto tipoHabitacionUpdateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

            return Ok(await _svTipoHabitacion.Update(id, tipoHabitacionUpdateDto, userId));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }
            return Ok(await _svTipoHabitacion.Delete(id, userId));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
