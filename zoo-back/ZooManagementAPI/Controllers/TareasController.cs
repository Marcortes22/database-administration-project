using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.TareasService;
using Services.TareasService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TareasController : ControllerBase
    {
        private readonly ISvTarea svTarea;

        public TareasController(ISvTarea svTarea)
        {
            this.svTarea = svTarea;
        }


        [HttpGet("controlAnimal")]
        public async Task<IActionResult> GetAllControlAnimal()
        {
            try
            {
                var response = await svTarea.GetAllControlAnimal();
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("mantenimiento")]
        public async Task<IActionResult> GetAllMantenimiento()
        {
            try
            {
                var response = await svTarea.GetAllMantenimiento();
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }



        [HttpGet("controlAnimal-empleado")]
        public async Task<IActionResult> GetTasksControlAnimalByEmpleadoId(int id)
        {
            try
            {
                var response = await svTarea.GetTasksControlAnimalByEmpleadoId(id);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("mantenimiento-empleado")]
        public async Task<IActionResult> GetTasksMantenimientoByEmpleadoId(int id)
        {
            try
            {
                var response = await svTarea.GetTasksMantenimientoByEmpleadoId(id);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPut("caambiarEstado-")]
        public async Task<IActionResult> AtualizarEstado([FromBody] ChangeTaskStateDto cambiarEstadoTareaDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await svTarea.AtualizarEstado(cambiarEstadoTareaDto, userId);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }






    }
}
