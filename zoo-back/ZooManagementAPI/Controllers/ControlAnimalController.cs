using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.ControlAnimalService;
using Services.ControlAnimalService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ControlAnimalController : ControllerBase
    {
        private readonly ISvControlAnimal _svControlAnimal;

        public ControlAnimalController(ISvControlAnimal svControlAnimal)
        {
            _svControlAnimal = svControlAnimal;
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateControlAnimalDto controlAnimalDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await _svControlAnimal.newControlAnimalTask(controlAnimalDto, userId);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
