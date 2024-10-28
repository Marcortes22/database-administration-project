using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.AlimentosService;
using Services.AlimentosService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AlimentoController : ControllerBase
    {
        private readonly ISvAlimentos svAlimento;

        public AlimentoController(ISvAlimentos _svAlimento)
        {
            svAlimento = _svAlimento;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var result = await svAlimento.GetAll();

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
                var result = await svAlimento.GetById(id);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]

        [HttpPost]

        public async Task<IActionResult> Create([FromBody] AlimentosCreateDto alimentoCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svAlimento.Create(alimentoCreateDto, userId);

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
                var result = await svAlimento.Delete(id, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut]

        public async Task<IActionResult> Update(int id, [FromBody] AlimentosUpdateDto alimentoUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svAlimento.Update(id, alimentoUpdateDto, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}