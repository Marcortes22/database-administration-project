using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.RolService;
using Services.RolService.Dto;
namespace ZooManagementAPI.Controllers
{
    //[Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class RolController : ControllerBase
    {
        private readonly ISvRole _svRol;
        public RolController(ISvRole svRol)
        {
            
            _svRol = svRol;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            try
            {
            return Ok(await _svRol.GetAll());

            }catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


        //[HttpGet("{id}")]
        //public async Task<IActionResult> Get(int id)
        //{
        //    return Ok(await _svRol.GetById(id));
        //}
        //[Authorize(Roles = "ADMIN")]\

        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] RoleCreateDto rolCreateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }
                return Ok(await _svRol.Create(rolCreateDto, userId));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] RoleUpdateDto rolUpdateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }
            return Ok(await _svRol.Update(id, rolUpdateDto, userId));

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
            return Ok(await _svRol.Delete(id, userId));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
