using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.ZooService;
using Services.ZooService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ZooController : ControllerBase
    {
        private readonly ISvZoo _svZoo;
        public ZooController(ISvZoo svZoo)
        {
            _svZoo = svZoo;
        }


        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            try
            {

            return Ok(await _svZoo.GetById(id));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] ZooCreateDto zooCreateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }
            return Ok(await _svZoo.Create(zooCreateDto, userId));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }


        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] ZooUpdateDto zooUpdateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

            return Ok(await _svZoo.Update(id, zooUpdateDto, userId));
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

            return Ok(await _svZoo.Delete(id, userId));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
