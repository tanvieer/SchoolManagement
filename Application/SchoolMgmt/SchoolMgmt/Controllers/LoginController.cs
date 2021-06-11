using Microsoft.AspNetCore.Mvc;
using SchoolMgmt.Controllers.Services;
using SchoolMgmt.Model;
using SchoolMgmt.Model.SysModel;
using SchoolMgmt.Model.ViewModel;
using SchoolMgmt.Repository;

namespace SchoolMgmt.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        [HttpPost]

        public StatusResult<JwtPacket> Login([FromBody] LoginViewModel model)
        { 
            StatusResult<JwtPacket> result = new StatusResult<JwtPacket>();
            var user = SysManageRepository.VerifyUser(model);
            if (user.P_OUT == 1)
            {
                result.Status = "FAILED";
                result.Message = user.ErrorCode + " ~ " + user.ErrorMsg;
            }
            else
            { 
                result.Status = "FAILED";
                result.Message = "Successfully Logged In.";
                result.Result = UtilityService.CreateJwtPacket(user);
            }             
            return result;              
        }
    }
}
