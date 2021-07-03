using SchoolMgmt.Repository;
using SchoolMngmnt.Model;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Models.DbModel;
using SchoolMngmnt.Repository; 
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace SchoolMngmnt.Controllers
{
    public class ClassController : ApiController
    { 


        [HttpGet]
        [Route("api/Class/GetClassList")]
        public StatusResult<List<TucClass>> GetClassList()
        {

            StatusResult<List<TucClass>> rslt = new StatusResult<List<TucClass>>();
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

            if (checkSession.Result.RoleId == 1 || checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.GetClassList(checkSession.Result.UserName);
            }
            else  
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }



        [HttpGet]
        [Route("api/Class/GetClassInfo")]
        public StatusResult<TucClass> GetClassInfo(string id)
        {

            StatusResult<TucClass> rslt = new StatusResult<TucClass>();
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

            if (checkSession.Result.RoleId == 1 || checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.GetClassInfo(id, checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }



        [HttpPost]
        [Route("api/Class/ModifyClassInfo")]
        public StatusResult<TucClass> ModifyClassInfo([FromBody] TucClass model)
        {

            StatusResult<TucClass> rslt = new StatusResult<TucClass>();
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

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                rslt = SpCall.ManageClass(model, "U");
            }
            else
            {
                rslt.Message = "This user has no permission to modify class info.";
            }

            return rslt;
        }



        [HttpPost]
        [Route("api/Class/AddNewClass")]
        public StatusResult<TucClass> AddNewClass([FromBody] TucClass model)
        {

            StatusResult<TucClass> rslt = new StatusResult<TucClass>();
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

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                rslt = SpCall.ManageClass(model, "I");
            }
            else
            {
                rslt.Message = "This user has no permission to modify class info.";
            }

            return rslt;
        }



        [HttpDelete]
        [Route("api/Class/DeleteClass")]
        public StatusResult<TucClass> DeleteClass(string id)
        {

            StatusResult<TucClass> rslt = new StatusResult<TucClass>();
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

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                TucClass model = new TucClass();
                model.ClassId = id;
                model.make_by = checkSession.Result.UserName;
                rslt = SpCall.ManageClass(model, "D");
            }
            else
            {
                rslt.Message = "This user has no permission to delete class.";
            }

            return rslt;
        }



    }
}
