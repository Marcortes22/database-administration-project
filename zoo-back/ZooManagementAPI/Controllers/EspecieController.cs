using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.EspecieServices;
using Services.EspecieServices.Dto;

namespace ZooManagementAPI.Controllers
{

    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class EspecieController : ControllerBase
    {
        private readonly ISvEspecie svEspecie;

        public EspecieController(ISvEspecie _svEspecie)
        {
            svEspecie = _svEspecie;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var result = await svEspecie.GetAll();

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
                var result = await svEspecie.GetById(id);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost]

        public async Task<IActionResult> Create([FromBody] EspecieCreateDto especieCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svEspecie.Create(especieCreateDto, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] EspecieUpdateDto especieUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var result = await svEspecie.Update(id, especieUpdateDto, userId);

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
                var result = await svEspecie.Delete(id, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


    }
}
