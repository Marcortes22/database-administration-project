using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.MetodoPagoService;
using Services.MetodoPagoService.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class MetodoPagoController : ControllerBase
    {
        private readonly ISvMetodoPago _svMetodoPago;

        public MetodoPagoController(ISvMetodoPago svMetodoPago)
        {
            _svMetodoPago = svMetodoPago;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var response = await _svMetodoPago.GetAll();
     
               return Ok(response);
                
            }
            catch (Exception err)
            {
                return BadRequest(err.Message);
            }
        }

        //[HttpGet("{id}")]
        //public async Task<IActionResult> GetById(int id)
        //{
        //    var response = await _svMetodoPago.GetById(id);
        //    if (response.Success)
        //    {
        //        return Ok(response);
        //    }
        //    return BadRequest(response);
        //}
        [Authorize(Roles = "ADMIN")]
        [HttpPost]
        public async Task<IActionResult> Create(MetodoPagoCreateDto metodoPagoCreateDto)
        {
            try
            {
             int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }

                return Ok(await _svMetodoPago.Create(metodoPagoCreateDto, userId));
            
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Update(int id, MetodoPagoUpdateDto metodoPagoUpdateDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                var response = await _svMetodoPago.Update(id, metodoPagoUpdateDto, userId);
            
                return Ok(response);
            
            
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                var response = await _svMetodoPago.Delete(id, userId);
           
                return Ok(response);
            
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
