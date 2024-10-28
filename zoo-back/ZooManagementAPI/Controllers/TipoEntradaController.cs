using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.TipoEntradaService;
using Services.TipoEntradaService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TipoEntradaController : ControllerBase
    {
        private readonly ISvTipoEntrada _svTipoEntrada;

        public TipoEntradaController(ISvTipoEntrada svTipoEntrada)
        {
            _svTipoEntrada = svTipoEntrada;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var response = await _svTipoEntrada.GetAll();

                return Ok(response);

            }
            catch (Exception err)
            {
                return BadRequest(err.Message);
            }
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            try
            {
                var response = await _svTipoEntrada.GetById(id);

                return Ok(response);


            }
            catch (Exception err)
            {
                return BadRequest(err.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]

        [HttpPost]
        public async Task<IActionResult> Create(TipoEntradaCreateDto tipoEntradaCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                return Ok(await _svTipoEntrada.Create(tipoEntradaCreateDto, userId));
            }
            catch (Exception err)
            {
                return BadRequest(err.Message);
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

                return Ok(await _svTipoEntrada.Delete(id, userId));
            }
            catch (Exception err)
            {
                return BadRequest(err.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, TipoEntradaUpdateDto tipoEntradaUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                return Ok(await _svTipoEntrada.Update(id, tipoEntradaUpdateDto, userId));

            }
            catch (Exception err)
            {
                return BadRequest(err.Message);
            }


        }
    }
}
