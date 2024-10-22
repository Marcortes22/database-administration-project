
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Services;
using Services.Auth;
using Services.Auth.Dto;



namespace ZooManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly ISvAuth svAuth;
        public AuthController(ISvAuth _svAuth)
        {
            svAuth = _svAuth;
        }

        [Authorize(Roles = "ADMIN")]
        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterDto registerDto)
        {
            try
            {
                int userId = int.Parse(User.FindFirst("Id").Value);

                if (userId == 0)
                {
                    return Unauthorized();
                }
                var result = await svAuth.Create(registerDto, userId);

                return Ok(result);
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
        {
            try
            {

            var result = await svAuth.Login(loginDto);

            var token = AuthHelpers.GenerateJWTToken(result.Data);

            return Ok(new { access_token = token });

            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
