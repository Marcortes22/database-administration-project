using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.EstadoHabitacionService;
using Services.EstadoHabitacionService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class EstadoHabitacionController : ControllerBase
    {
        private readonly ISvEstadoHabitacion _svEstadoHabitacion;

        public EstadoHabitacionController(ISvEstadoHabitacion svEstadoHabitacion)
        {
            _svEstadoHabitacion = svEstadoHabitacion;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var response = await _svEstadoHabitacion.GetAll();
            return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            try
            {
                var response = await _svEstadoHabitacion.GetById(id);
            return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] EstadoHabitacionCreateDto estadoHabitacionCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await _svEstadoHabitacion.Create(estadoHabitacionCreateDto, userId);
            return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] EstadoHabitacionUpdateDto estadoHabitacionUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await _svEstadoHabitacion.Update(id, estadoHabitacionUpdateDto, userId);
                return Ok(response);
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
                var response = await _svEstadoHabitacion.Delete(id, userId);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
