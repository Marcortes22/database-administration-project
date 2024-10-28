using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.PuestoService;
using Services.PuestoService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class PuestoController : ControllerBase
    {
        private readonly ISvPuesto _svPuesto;
        public PuestoController(ISvPuesto svPuesto)
        {
            _svPuesto = svPuesto;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {

            return Ok(await _svPuesto.GetAll());
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            return Ok(await _svPuesto.GetById(id));
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] PuestoCreateDto puestoCreateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

            return Ok(await _svPuesto.Create(puestoCreateDto, userId));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] PuestoUpdateDto puestoUpdateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                 return Ok(await _svPuesto.Update(id, puestoUpdateDto, userId));

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
                 return Ok(await _svPuesto.Delete(id, userId));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
