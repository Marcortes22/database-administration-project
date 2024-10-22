using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Data;

using Entities;
using Services.Auth.Dto;
namespace ZooManagementAPI
    
{
    public class AuthHelpers
    {
        public static string GenerateJWTToken(EmpleadoInfoDto empleado)
        {
            var claims = new List<Claim> {
                new Claim("Id", empleado.IdEmpleado.ToString()),
                new Claim("Nombre", empleado.Nombre),
                new Claim("Email", empleado.Correo),
                new Claim("Apellido1", empleado.Apellido1),
                new Claim("Apellido2", empleado.Apellido2)

            };


            foreach (var rol in empleado.Roles)
            {
                claims.Add(new Claim("Role", rol.Nombre));
            }




            var jwtToken = new JwtSecurityToken(
                claims: claims,
                notBefore: DateTime.UtcNow,
                expires: DateTime.UtcNow.AddDays(30),
                signingCredentials: new SigningCredentials(
                    new SymmetricSecurityKey(
                       Encoding.UTF8.GetBytes("ZooProjectZooProjectZooProjectZooProjectZooProject")
                        ),
                    SecurityAlgorithms.HmacSha256Signature)
                );
            return new JwtSecurityTokenHandler().WriteToken(jwtToken);
        }
    }
}
