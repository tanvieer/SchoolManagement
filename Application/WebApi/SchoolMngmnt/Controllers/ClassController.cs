using SchoolMgmt.Repository;
using SchoolMngmnt.Model;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Models.DbModel;
using SchoolMngmnt.Repository; 
using System.Collections.Generic; 
using System.Web.Http;

namespace SchoolMngmnt.Controllers
{
    public class ClassController : ApiController
    { 


        [HttpPost]
        [Route("api/Class/GetClassList")]
        public StatusResult<List<TucClass>> GetClassList([FromBody] JwtPacket model)
        {

            StatusResult<List<TucClass>> rslt = new StatusResult<List<TucClass>>();
            var checkSession =  SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1 || checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.GetClassList(model.make_by);
            }
            else  
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }



        [HttpPost]
        [Route("api/Class/GetClassInfo")]
        public StatusResult<TucClass> GetClassInfo([FromBody] JwtPacket model)
        {

            StatusResult<TucClass> rslt = new StatusResult<TucClass>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1 || checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.GetClassInfo(model.getIdKey,model.make_by);
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
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

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
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

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



        [HttpPost]
        [Route("api/Class/DeleteClass")]
        public StatusResult<TucClass> DeleteClass([FromBody] TucClass model)
        {

            StatusResult<TucClass> rslt = new StatusResult<TucClass>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
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
