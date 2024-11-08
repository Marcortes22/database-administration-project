using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.VisitanteService;
using Services.VisitanteService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class VisitanteController : ControllerBase
    {
        private readonly ISvVisitante _svVisitante;

        public VisitanteController(ISvVisitante svVisitante)
        {
            _svVisitante = svVisitante;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var response = await _svVisitante.GetAll();

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
                var response = await _svVisitante.GetById(id);
                return Ok(response);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }

        }

        [Authorize(Roles = "SELLER")]
        [HttpPost]
        public async Task<IActionResult> Create(VisitanteCreateDto visitanteCreateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                return Ok(await _svVisitante.Create(visitanteCreateDto, userId));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, VisitanteUpdateDto visitanteUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                return Ok(await _svVisitante.Update(id, visitanteUpdateDto, userId));

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

                return Ok(await _svVisitante.Delete(id, userId));

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
