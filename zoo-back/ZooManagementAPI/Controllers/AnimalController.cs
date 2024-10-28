using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.AnimalService;
using Services.AnimalService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AnimalController : ControllerBase
    {
        private readonly ISvAnimal _svAnimal;

        public AnimalController(ISvAnimal svAnimal)
        {
            _svAnimal = svAnimal;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var response = await _svAnimal.GetAll();
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
                var response = await _svAnimal.GetById(id);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] AnimalCreateDto animalCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await _svAnimal.Create(animalCreateDto, userId);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] AnimalUpdateDto animalUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await _svAnimal.Update(id, animalUpdateDto, userId);
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
                var response = await _svAnimal.Delete(id, userId);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost("move/{id}")]
        public async Task<IActionResult> MoveAnimal(int id, [FromBody] MoveAnimalDto moveAnimalDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await _svAnimal.MoveAnimal(id, moveAnimalDto, userId);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
