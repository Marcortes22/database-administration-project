using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.DietaService;
using Services.DietaService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class DietaController : ControllerBase
    {
        private readonly ISvDieta svDieta;

        public DietaController(ISvDieta _svDieta)
        {
            svDieta = _svDieta;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var result = await svDieta.GetAll();

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
                var result = await svDieta.GetById(id);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] DietaCreateDto dietaCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svDieta.Create(dietaCreateDto, userId);

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
                var result = await svDieta.Delete(id, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut]
        public async Task<IActionResult> Update(int id, [FromBody] DietaUpdateDto dietaUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svDieta.Update(id, dietaUpdateDto, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }


        }
    }
}