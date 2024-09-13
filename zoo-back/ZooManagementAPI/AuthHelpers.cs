using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Enitities;
using System.Data;

namespace ZooManagementAPI
{
    public class AuthHelpers
    {
        public static string GenerateJWTToken(User user, string role = "USER")
        {
            var claims = new List<Claim> {
                new Claim("Name", user.Name),
                new Claim("Email", user.Email),
                new Claim("Role", role),
                new Claim("Id", user.Id.ToString()),
                new Claim("Phone", user.CellPhone)

            };
            // string[] roles = ["uno", "dos"];

           // foreach (var rol in roles)
           // {
            //    claims.Add(new Claim("cosas", rol));
           // }




                var jwtToken = new JwtSecurityToken(
                claims: claims,
                notBefore: DateTime.UtcNow,
                expires: DateTime.UtcNow.AddDays(30),
                signingCredentials: new SigningCredentials(
                    new SymmetricSecurityKey(
                       Encoding.UTF8.GetBytes("ClinicInitialJWB_ClinicInitialJWB")
                        ),
                    SecurityAlgorithms.HmacSha256Signature)
                );
            return new JwtSecurityTokenHandler().WriteToken(jwtToken);
        }
    }
}
