using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.TipoTareaService;
using Services.TipoTareaService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TipoTareaController : ControllerBase
    {
        private readonly ISvTipoTarea _tipoTareaService;

        public TipoTareaController(ISvTipoTarea tipoTareaService)
        {
            _tipoTareaService = tipoTareaService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var response = await _tipoTareaService.GetAll();
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var response = await _tipoTareaService.GetById(id);
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }
        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] TipoTareaCreateDto tipoTareaCreateDto)
        {

            int userId = int.Parse(User.FindFirst("Id").Value);
            var response = await _tipoTareaService.Create(tipoTareaCreateDto, userId);
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [Authorize(Roles = "ADMIN")]
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            int userId = int.Parse(User.FindFirst("Id").Value);
            var response = await _tipoTareaService.Delete(id, userId);
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, [FromBody] TipoTareaUpdateDto tipoTareaUpdateDto)
        {
            int userId = int.Parse(User.FindFirst("Id").Value);
            var response = await _tipoTareaService.Update(id, tipoTareaUpdateDto, userId);
            if (response.Success)
            {
                return Ok(response);
            }
            return BadRequest(response);
        }
    }
}
