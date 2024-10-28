using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.HabitacionService;
using Services.HabitacionService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class HabitacionController : ControllerBase
    {
        private readonly ISvHabitacion _svHabitacion;
        public HabitacionController(ISvHabitacion svHabitacion)
        {
            _svHabitacion = svHabitacion;
        }
        [HttpGet]
        public async Task<IActionResult> Get()
        {

            return Ok(await _svHabitacion.GetAll());
        }


        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            try
            {

            return Ok(await _svHabitacion.GetById(id));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Post([FromBody] HabitacionCreateDto habitacionCreateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                return Ok(await _svHabitacion.Create(habitacionCreateDto, userId));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }

       [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] HabitacionUpdateDto habitacionUpdateDto)
        {

            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                return Ok(await _svHabitacion.Update(id, habitacionUpdateDto, userId));

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

                return Ok(await _svHabitacion.Delete(id, userId));
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }




    }
}
