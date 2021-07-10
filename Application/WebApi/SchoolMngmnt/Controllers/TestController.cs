using SchoolMgmt.Repository;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Models.DbModel;
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
    public class TestController : ApiController
    {
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Test/GetTestList")]
        public StatusResult<List<TucTest>> GetTestList(string subjectId)
        {

            StatusResult<List<TucTest>> rslt = new StatusResult<List<TucTest>>();
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

            rslt = SpCall.GetTestList(subjectId,checkSession.Result.UserName);

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Test/GetTestInfo")]
        public StatusResult<TucTest> GetTestInfo(string testId)
        {

            StatusResult<TucTest> rslt = new StatusResult<TucTest>();
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

            if (checkSession.Result.RoleId == 1 || checkSession.Result.RoleId == 2 || checkSession.Result.RoleId == 3) // ADMIN or teacher
            {
                rslt = SpCall.GetTestInfo(testId, checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to get Test list.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/Test/ModifyTestInfo")]
        public StatusResult<TestViewModel> ModifyTestInfo([FromBody] TestViewModel model)
        {

            StatusResult<TestViewModel> rslt = new StatusResult<TestViewModel>();
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
                rslt = SpCall.ManageTest(model, "U", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to modify Test info.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/Test/AddNewTest")]
        public StatusResult<TestViewModel> AddNewTest([FromBody] TestViewModel model)
        {

            StatusResult<TestViewModel> rslt = new StatusResult<TestViewModel>();
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
                rslt = SpCall.ManageTest(model, "I", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to Add New Test.";
            }

            return rslt;
        }


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpDelete]
        [Route("api/Test/DeleteTest")]
        public StatusResult<TestViewModel> DeleteTest(string id)
        {

            StatusResult<TestViewModel> rslt = new StatusResult<TestViewModel>();
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
                TestViewModel model = new TestViewModel();
                model.TestId = id;
                rslt = SpCall.ManageTest(model, "D", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to delete Test.";
            }

            return rslt;
        }

    }
}
