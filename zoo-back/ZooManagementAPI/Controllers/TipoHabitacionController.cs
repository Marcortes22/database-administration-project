using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.TipoHabitacionService;
using Services.TipoHabitacionService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TipoHabitacionController : ControllerBase
    {
        private readonly ISvTipoHabitacion _svTipoHabitacion;
        public TipoHabitacionController(ISvTipoHabitacion svTipoHabitacion)
        {
            _svTipoHabitacion = svTipoHabitacion;
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {

            return Ok(await _svTipoHabitacion.GetAll());
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            return Ok(await _svTipoHabitacion.GetById(id));
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] tipoHabitacionCreateDto tipoHabitacionCreateDto)
        {

            return Ok( await _svTipoHabitacion.Create(tipoHabitacionCreateDto));
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] tipoHabitacionUpdateDto tipoHabitacionUpdateDto)
        {
            return Ok(await _svTipoHabitacion.Update(id, tipoHabitacionUpdateDto));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            return Ok(await _svTipoHabitacion.Delete(id));
        }
    }
}
