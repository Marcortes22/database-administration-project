
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Services;



namespace ZooManagementAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly ZooMaContext _context;
        public AuthController(ZooMaContext context)
        {
            _context = context;
        }
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


        [HttpGet("testDB")]
        async public Task<IActionResult> Getdb()
        {
            // Ejecutar una consulta SQL cruda que devuelve nombres de bases de datos
            var result = await _context.Database
                .SqlQueryRaw<string>("SELECT name FROM sys.databases")
                .ToListAsync();

            return Ok(result);
        }
    }
}
