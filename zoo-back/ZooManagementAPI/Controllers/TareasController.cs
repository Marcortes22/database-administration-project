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

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var response = await svTarea.GetAll();
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet("tasksByEmpleado{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            try
            {
                var response = await svTarea.GetTasksByEmpleadoId(id);
                return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPut("caambiarEstado")]
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
