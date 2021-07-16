
using SchoolMgmt.Repository;
using SchoolMngmnt.Model;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Model.ViewModel;
using SchoolMngmnt.Models.ViewModel;
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
               
            }
            else
            {
                rslt.Status = "FAILED";
                rslt.Message = "User not logged in!!";
                return rslt;
            }

            var checkSession = SysManageRepository.CheckSession(token);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            rslt = SysManageRepository.ManageUser(model, "I",checkSession.Result.UserName);

            return rslt;
        }

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/User/ChangePassword")]
        public StatusResult<string> ChangePassword([FromBody] ChangePasswordViewModel model)
        {
            StatusResult<string> rslt = new StatusResult<string>();
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
                rslt.Message = "User not logged in!!";
                return rslt;
            }

            var checkSession = SysManageRepository.CheckSession(token);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }
             if (model.OldPassword == model.NewPassword)
            {
                rslt.Status = "FAILED";
                rslt.Message = "Old Password and New Password cannot be same.";
                return rslt;
            }

            if (checkSession.Result.UserName == model.UserName) // ADMIN
            {
                rslt = SysManageRepository.ChangePassword(model.UserName, model.OldPassword,model.NewPassword);
            }
            else
            {
                rslt.Status = "FAILED";
                rslt.Message = "User can only change own password.";
            }

            return rslt;
        }





        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/User/ResetPassword")]
        public StatusResult<string> ResetPassword([FromBody] LoginViewModel model)
        {
            StatusResult<string> rslt = new StatusResult<string>();
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
                rslt.Message = "User not logged in!!";
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
                rslt = SysManageRepository.ResetPassword(model.UserName,model.Password, checkSession.Result.UserName);
            }
            else
            {
                rslt.Status = "FAILED";
                rslt.Message = "Only admin can reset password.";
            }

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
            }
            else
            {
                rslt.Status = "FAILED";
                rslt.Message = "User not logged in!!";
                return rslt;
            }
            var checkSession = SysManageRepository.CheckSession(token);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            rslt = SysManageRepository.ManageUser(model, "U", checkSession.Result.UserName);

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
                rslt.Message = "User not logged in!!";
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
                rslt = SysManageRepository.GetUserList(userType, token, checkSession.Result.Id);
            }
            else if (checkSession.Result.RoleId == 2 && userType == 3) // Teacher
            {
                rslt = SysManageRepository.GetUserList(3, token,checkSession.Result.Id);
            }  
             
            return rslt;
             
        }



        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/User/GetRouterLinks")]
        public StatusResult<List<RouterLinkViewModel>> GetRouterLinks()
        {

            StatusResult<List<RouterLinkViewModel>> rslt = new StatusResult<List<RouterLinkViewModel>>();
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
                rslt.Message = "User not logged in!!";
                return rslt;
            }

            var checkSession = SysManageRepository.CheckSession(token);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            rslt = SysManageRepository.GetRouterLinks(checkSession.Result.UserName);

            return rslt;
             
        }






        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/User/GetStudentListByClssId")]
        public StatusResult<List<UserMaster>> GetStudentListByClssId(int id)
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
                rslt.Message = "User not logged in!!";
                return rslt;
            }

            var checkSession = SysManageRepository.CheckSession(token);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 2 || checkSession.Result.RoleId == 1) // ADMIN or Teacher
            {
                rslt = SysManageRepository.GetStudentListByClassId(id, checkSession.Result.UserName);
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
                rslt.Message = "User not logged in!!";
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



        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpDelete]
        [Route("api/User/DeleteUser")]
        public StatusResult<UserMaster> DeleteUser(string userName)
        {

            StatusResult<UserMaster> rslt = new StatusResult<UserMaster>();
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
                rslt.Message = "User not logged in!!";
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
                UserViewModel model = new UserViewModel();
                model.UserName = userName;
                rslt  = SysManageRepository.ManageUser(model, "D", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to delete user.";
            }

            return rslt;
        }



    }
}
