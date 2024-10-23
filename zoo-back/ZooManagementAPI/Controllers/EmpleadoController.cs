using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.EmpleadoService;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class EmpleadoController : ControllerBase
    {
        private readonly ISvEmpleado svEmpleado;
        public EmpleadoController(ISvEmpleado _svEmpleado)
        {
            svEmpleado = _svEmpleado;
        }



        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var result = await svEmpleado.GetAll();

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
                var result = await svEmpleado.GetById(id);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
