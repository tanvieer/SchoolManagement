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
    public class SubjectController : ApiController
    {

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Subject/GetSubjectList")]
        public StatusResult<List<TucSubject>> GetSubjectList()
        {

            StatusResult<List<TucSubject>> rslt = new StatusResult<List<TucSubject>>();
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
                rslt = SpCall.GetSubjectList(checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Subject/GetSubjectInfo")]
        public StatusResult<TucSubject> GetSubjectInfo(string id)
        {
            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();
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
                rslt = SpCall.GetSubjectInfo(id, checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/Subject/ModifySubjectInfo")]
        public StatusResult<TucSubject> ModifySubjectInfo([FromBody] TucSubject model)
        {

            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();
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
                rslt = SpCall.ManageSubject(model, "U", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to modify class info.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/Subject/AddNewSubject")]
        public StatusResult<TucSubject> AddNewSubject([FromBody] TucSubject model)
        {

            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();
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
                rslt = SpCall.ManageSubject(model, "I", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to modify class info.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpDelete]
        [Route("api/Subject/DeleteSubject")]
        public StatusResult<TucSubject> DeleteSubject(string id)
        {

            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();
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
                TucSubject model = new TucSubject();
                model.SubjectId = id; 
                rslt = SpCall.ManageSubject(model, "D", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to delete class.";
            }

            return rslt;
        }


        //   public static StatusResult<TucClassSubjectMap> ClassSubjectMap(TucClassSubjectMap model , string p_activity)

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/Subject/ClassSubjectMap")]
        public StatusResult<TucClassSubjectMap> ClassSubjectMap([FromBody] TucClassSubjectMap model)
        {

            StatusResult<TucClassSubjectMap> rslt = new StatusResult<TucClassSubjectMap>();
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
                rslt = SpCall.ClassSubjectMap(model, "I", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to class subject mapping.";
            }

            return rslt;
        }

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpDelete]
        [Route("api/Subject/ClassSubjectMapRemove")]
        public StatusResult<TucClassSubjectMap> ClassSubjectMapRemove(string classId,string subjectId)
        {

            StatusResult<TucClassSubjectMap> rslt = new StatusResult<TucClassSubjectMap>();
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
                TucClassSubjectMap model = new TucClassSubjectMap(); 
                model.ClassId = classId;
                model.SubjectId = subjectId;
                rslt = SpCall.ClassSubjectMap(model, "D", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to delete class subject mapping.";
            }

            return rslt;
        }

    }
}
