using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Services.EstadoTareaServices;
using Services.EstadoTareaServices.Dto;

namespace ZooManagementAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class EstadoTareaController : ControllerBase
    {

        private readonly ISvEstadoTarea _svEstadoTarea;

        public EstadoTareaController(ISvEstadoTarea svEstadoTarea)
        {
            _svEstadoTarea = svEstadoTarea;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            try
            {
             var response = await _svEstadoTarea.GetAll();
            return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


        [HttpGet]
        [Route("{id}")]

        public async Task<IActionResult> GetById(int id)
        {
            try
            {
             var response = await _svEstadoTarea.GetById(id);
            return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }


        [HttpPost]
        public async Task<IActionResult> Create(EstadoTareaCreateDto estadoTareaCreateDto)
        {
            try {
                int userId = int.Parse(User.FindFirst("Id").Value);

                var response = await _svEstadoTarea.Create(estadoTareaCreateDto, userId);
            return Ok(response);

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpDelete]
        [Route("delete/{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            try {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await _svEstadoTarea.Delete(id, userId);
            return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }



        [HttpPut]
        [Route("{id}")]
        public async Task<IActionResult> Update(int id, EstadoTareaUpdateDto estadoTareaUpdateDto)
        {
            try {
                int userId = int.Parse(User.FindFirst("Id").Value);
                var response = await _svEstadoTarea.Update(id, estadoTareaUpdateDto, userId);
            return Ok(response);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

       


    }
}
