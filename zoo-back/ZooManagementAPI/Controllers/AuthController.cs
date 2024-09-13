using Enitities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;


namespace ZooManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        [HttpPost("Login")]
        public IActionResult GetToken()
        {
            User user = new User { Id = 6, CellPhone = "45454", Email = "masr", Name = "marco" };
            var token = AuthHelpers.GenerateJWTToken(user, "ADMIN");
            var tokenObject = new { access_token = token };

            return Ok(tokenObject);
        }

        [Authorize(Roles = "ADMIN")]
        [HttpGet("test")]
        public IActionResult Getsome()
        {


            return Ok("SIIIIII");
        }
    }
}
