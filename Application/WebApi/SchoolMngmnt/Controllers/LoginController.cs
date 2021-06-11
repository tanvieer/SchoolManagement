using SchoolMgmt.Repository;
using SchoolMngmnt.Controllers.Services;
using SchoolMngmnt.Model;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Model.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace SchoolMngmnt.Controllers
{
    public class LoginController : ApiController
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
