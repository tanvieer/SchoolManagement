
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
            var re = Request;
            var headers = re.Headers;
            string token = "";

            if (headers.Contains("Authorization"))
            {
                token = headers.GetValues("Authorization").First();
                var checkSession = SysManageRepository.CheckSession(token);

                if (checkSession.Status == "FAILED")
                {
                    rslt.Status = checkSession.Status;
                    rslt.Message = checkSession.Message;
                    return rslt;
                }
            }
            else
            {
                rslt.Status = "FAILED";
                rslt.Message = "User token not found!";
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
            var re = Request;
            var headers = re.Headers;
            string token = "";

            if (headers.Contains("Authorization"))
            {
                token = headers.GetValues("Authorization").First();
                var checkSession = SysManageRepository.CheckSession(token);

                if (checkSession.Status == "FAILED")
                {
                    rslt.Status = checkSession.Status;
                    rslt.Message = checkSession.Message;
                    return rslt;
                }
            }
            else
            {
                rslt.Status = "FAILED";
                rslt.Message = "User token not found!";
                return rslt;
            }

            rslt = SysManageRepository.ManageUser(model, "U");

            return rslt;
        }

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/User/GetUserList")]
        public StatusResult<List<UserMaster>> GetUserList(int userType)
        {

            StatusResult<List<UserMaster>> rslt = new StatusResult<List<UserMaster>>();
            var re = Request;
            var headers = re.Headers;
            string token = ""; 

            if (headers.Contains("Authorization"))
            {
                token = headers.GetValues("Authorization").First();
               
            }
            else
            {
                rslt.Status = "FAILED";
                rslt.Message = "User token not found!";
                return rslt;
            }

            var checkSession = SysManageRepository.CheckSession(token);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1) // ADMIN
            {
                rslt = SysManageRepository.GetUserList(userType, token);
            }
            else if (checkSession.Result.RoleId == 2) // Teacher
            {
                rslt = SysManageRepository.GetUserList(userType, token);
            }
             
            return rslt;
             
        }

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/User/Get")]
        public StatusResult<UserMaster> Get(string id)
        {
            var re = Request;
            var headers = re.Headers;
            string token = "";
            StatusResult <UserMaster> rslt = new StatusResult<UserMaster>();

            if (headers.Contains("Authorization"))
            {
                token = headers.GetValues("Authorization").First();
            }
            else
            {
                rslt.Status = "FAILED";
                rslt.Message = "User token not found!";
                return rslt;
            }


            var checkSession = SysManageRepository.CheckSession(token);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }


            UserViewModel model = new UserViewModel();
            rslt = SysManageRepository.GetUserInfo(id, token); 
            return rslt;
        }



    }
}
