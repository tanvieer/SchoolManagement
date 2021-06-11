
using SchoolMgmt.Model; 
using SchoolMgmt.Repository;
using System;
using System.Security.Claims;
using System.Text;
using System.IdentityModel.Tokens;

namespace SchoolMgmt.Controllers.Services
{
    public class UtilityService
    {
         
     
        //public ActionResult Login(LoginViewModel loginData)
        //{
        //    var user = _userRepository.GetUserInfo(loginData);

        //    if (user.P_OUT == 1)
        //        return NotFound(user.ErrorCode + " ~ " + user.ErrorMsg);
        //    // User userEntiy = new User();
        //    return Ok(CreateJwtPacket(user));
        //}


        //[HttpPost]
        //public JwtPacket Register(UserViewModel user)
        //{
        //    var registerUser = _userRepository.RegisterUser(user);

        //    return CreateJwtPacket(registerUser);

        //}

        public static JwtPacket CreateJwtPacket(SYS_USER_MASTER user)//SigningCredentials
        {
            var key = Encoding.ASCII.GetBytes(user.Email + DateTime.UtcNow.ToString());
            var signingKey = new InMemorySymmetricSecurityKey(key);
         

            SigningCredentials signingCredentials = new SigningCredentials(signingKey, SecurityAlgorithms.HmacSha256Signature, SecurityAlgorithms.Sha256Digest);

            var claims = new Claim[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
                new Claim(ClaimTypes.Role, user.RoleName.ToUpper())
            };

            var jwt = new JwtSecurityToken(claims: claims, signingCredentials: signingCredentials);

            var encodedJwt = new JwtSecurityTokenHandler().WriteToken(jwt);

            return new JwtPacket()
            {
                Token = encodedJwt,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Email = user.RoleName,
                RoleId = user.RoleId,
                RoleName = user.RoleName
            };

        }
    }
}
