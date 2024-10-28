using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.EstadoSaludService;
using Services.EstadoSaludService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class EstadoSaludController : ControllerBase
    {
        private readonly ISvEstadoSalud svEstadoSalud;

        public EstadoSaludController(ISvEstadoSalud _svEstadoSalud)
        {
            svEstadoSalud = _svEstadoSalud;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var result = await svEstadoSalud.GetAll();

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("getById")]
        public async Task<IActionResult> GetById(int id)
        {
            try
            {
                var result = await svEstadoSalud.GetById(id);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles ="ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] EstadoSaludCreateDto estadoSaludCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svEstadoSalud.Create(estadoSaludCreateDto, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpDelete]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svEstadoSalud.Delete(id, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut]

        public async Task<IActionResult> Update(int id, [FromBody] EstadoSaludUpdateDto estadoSaludUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svEstadoSalud.Update(id, estadoSaludUpdateDto, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }
    }
}
