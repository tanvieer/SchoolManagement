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
            if (user.Status == "FAILED")
            {
                result.Status = "FAILED";
                result.Message = user.Message;
            }
            else
            {
                result.Status = "SUCCESS";
                result.Message = user.Message;
                result.Result = UtilityService.CreateJwtPacket(user.Result);
            }
            return result;
        }
    }
}
