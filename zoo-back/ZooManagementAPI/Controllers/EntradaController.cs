using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.EntradaService;
using Services.EntradaService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class EntradaController : ControllerBase
    {
        private readonly ISvEntrada svEntrada;

        public EntradaController(ISvEntrada _svEntrada)
        {
            svEntrada = _svEntrada;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var result = await svEntrada.GetAll();

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
                var result = await svEntrada.GetById(id);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost]

        public async Task<IActionResult> Create([FromBody] EntradaCreateDto entradaCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svEntrada.Create(entradaCreateDto, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]

        public async Task<IActionResult> Update(int id, [FromBody] EntradaUpdateDto entradaUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svEntrada.Update(id, entradaUpdateDto, userId);

                return Ok(result);
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
                var result = await svEntrada.Delete(id, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


    }
}
