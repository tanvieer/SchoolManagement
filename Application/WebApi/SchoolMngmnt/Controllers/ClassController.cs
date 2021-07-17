using SchoolMgmt.Repository;
using SchoolMngmnt.Model;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Models.DbModel;
using SchoolMngmnt.Repository; 
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Http.Cors;

namespace SchoolMngmnt.Controllers
{
    public class ClassController : ApiController
    {

        [EnableCors(origins: "*", headers: "*", methods: "*")]
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

            if (checkSession.Result.RoleId == 1 || checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.GetClassList(checkSession.Result.UserName,null,1);
            }
            else  
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }



        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Class/GetClassListBySubject")]
        public StatusResult<List<TucClass>> GetClassListBySubject(string subjectId)
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

            if (checkSession.Result.RoleId == 1 || checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.GetClassList(checkSession.Result.UserName, subjectId, 2);
            }
            else
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }



        [EnableCors(origins: "*", headers: "*", methods: "*")]
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

            if (checkSession.Result.RoleId == 1 ) // ADMIN or teacher
            {
                rslt = SpCall.GetClassInfo(id, checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
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

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                rslt = SpCall.ManageClass(model, "U", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to modify class info.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
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

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                rslt = SpCall.ManageClass(model, "I", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to add new class.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
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

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                TucClass model = new TucClass();
                model.ClassId = id; 
                rslt = SpCall.ManageClass(model, "D", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to delete class.";
            }

            return rslt;
        }



        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpDelete]
        [Route("api/Class/ArchiveClass")]
        public StatusResult<TucClass> ArchiveClass(string id)
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

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                TucClass model = new TucClass();
                model.ClassId = id;
                rslt = SpCall.ManageClass(model, "A", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to archive class.";
            }

            return rslt;
        }



    }
}
