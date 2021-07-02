
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
using System.Web.Http.Cors;

namespace SchoolMngmnt.Controllers
{
    public class UserController : ApiController
    {

        // POST: api/User
         [EnableCors(origins: "*", headers: "*", methods: "*")]
        //[EnableCors("AllowOrigin")] 
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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/User/GetUserList")]
        public StatusResult<List<UserMaster>> GetUserList([FromBody] JwtPacket model)
        {

            StatusResult<List<UserMaster>> rslt = new StatusResult<List<UserMaster>>();

            rslt = SysManageRepository.GetUserList(0, "s");

            return rslt;


            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1) // ADMIN
            {
                rslt = SysManageRepository.GetUserList(model.RoleId, model.Session);
            }
            else if (checkSession.Result.RoleId == 2) // Teacher
            { 
                rslt = SysManageRepository.GetUserList(model.RoleId, model.Session);
            }

            return rslt;
        }

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/User/Get")]
        public string Get()
        {  
            return "success";
        }




    }
}
