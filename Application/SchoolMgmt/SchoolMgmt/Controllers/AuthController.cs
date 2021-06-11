using Microsoft.AspNetCore.Mvc;
using SchoolMgmt.Model;
using SchoolMgmt.Model.SysModel;
using SchoolMgmt.Model.ViewModel;
using SchoolMgmt.Repository;
using System; 
using System.Security.Claims;
using System.Text;
using System.IdentityModel.Tokens;

namespace SchoolMgmt.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly SysManageRepository _userRepository;
        public AuthController(SysManageRepository authRepository)
        { 

            _userRepository = authRepository;

        }
        [HttpPost]
        public ActionResult Login(LoginViewModel loginData)
        {
            var user = _userRepository.GetUserInfo(loginData);

            if (user.P_OUT == 1)
                return NotFound(user.ErrorCode + " ~ " + user.ErrorMsg);
           // User userEntiy = new User();
            return Ok(CreateJwtPacket(user));
        }


        [HttpPost]
        public JwtPacket Register(UserViewModel user)
        {
            var registerUser = _userRepository.RegisterUser(user);

            return CreateJwtPacket(registerUser);

        }

        JwtPacket CreateJwtPacket(SYS_USER_MASTER user)//SigningCredentials
        {
            var signingKey = new InMemorySymmetricSecurityKey(Encoding.ASCII.GetBytes(user.Email + DateTime.UtcNow.ToString()));

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