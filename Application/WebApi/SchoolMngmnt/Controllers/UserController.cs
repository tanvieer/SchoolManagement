using SchoolMgmt.Repository;
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
    public class UserController : ApiController
    {
         
        // POST: api/User
        [HttpPost]
        [Route("api/User/Register")]
        public StatusResult<UserMaster> RegisterUser([FromBody] UserViewModel model)
        {

            StatusResult<UserMaster> rslt = new StatusResult<UserMaster>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }
             
            rslt = SysManageRepository.ManageUser(model, "I");

            return rslt;
        }

        [HttpPost]
        [Route("api/User/UpdateUser")]
        public StatusResult<UserMaster> UpdateUser([FromBody] UserViewModel model)
        {

            StatusResult<UserMaster> rslt = new StatusResult<UserMaster>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            rslt = SysManageRepository.ManageUser(model, "U");

            return rslt;
        }

    }
}
