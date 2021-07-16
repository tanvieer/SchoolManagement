using SchoolMgmt.Repository;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Models.ViewModel;
using SchoolMngmnt.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace SchoolMngmnt.Controllers
{
    public class StudentController : ApiController
    {

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Student/GetSubjectList")]
        public StatusResult<List<StudentSubjectListViewModel>> GetSubjectList()
        {

            StatusResult<List<StudentSubjectListViewModel>> rslt = new StatusResult<List<StudentSubjectListViewModel>>();
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

            if (checkSession.Result.RoleId == 3) // student
            {
                rslt = SpCall.GetSubjectByStudentUserName(checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to for this api.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Student/GetTestList")]
        public StatusResult<List<StudentTestListViewModel>> GetTestList(string subject_id)
        {

            StatusResult<List<StudentTestListViewModel>> rslt = new StatusResult<List<StudentTestListViewModel>>();
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

            if (checkSession.Result.RoleId == 3) // student
            {
                rslt = SpCall.GetTestListBySubject(subject_id,checkSession.Result.Id);
            }
            else
            {
                rslt.Message = "This user has no permission for this api.";
            }

            return rslt;
        }

    }
}
