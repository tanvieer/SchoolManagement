﻿using SchoolMgmt.Repository;
using SchoolMngmnt.Model;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Models.DbModel;
using SchoolMngmnt.Repository;
using System.Collections.Generic;
using System.Web.Http;

namespace SchoolMngmnt.Controllers
{
    public class SubjectController : ApiController
    {
        

        [HttpPost]
        [Route("api/Subject/GetSubjectList")]
        public StatusResult<List<TucSubject>> GetSubjectList([FromBody] JwtPacket model)
        {

            StatusResult<List<TucSubject>> rslt = new StatusResult<List<TucSubject>>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1 || checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.GetSubjectList(model.make_by);
            }
            else
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }



        [HttpPost]
        [Route("api/Subject/GetSubjectInfo")]
        public StatusResult<TucSubject> GetSubjectInfo([FromBody] JwtPacket model)
        {

            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1 || checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.GetSubjectInfo(model.getIdKey, model.make_by);
            }
            else
            {
                rslt.Message = "This user has no permission to get class list.";
            }

            return rslt;
        }



        [HttpPost]
        [Route("api/Subject/ModifySubjectInfo")]
        public StatusResult<TucSubject> ModifySubjectInfo([FromBody] TucSubject model)
        {

            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                rslt = SpCall.ManageSubject(model, "U");
            }
            else
            {
                rslt.Message = "This user has no permission to modify class info.";
            }

            return rslt;
        }



        [HttpPost]
        [Route("api/Subject/AddNewSubject")]
        public StatusResult<TucSubject> AddNewSubject([FromBody] TucSubject model)
        {

            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                rslt = SpCall.ManageSubject(model, "I");
            }
            else
            {
                rslt.Message = "This user has no permission to modify class info.";
            }

            return rslt;
        }

        [HttpPost]
        [Route("api/Subject/DeleteSubject")]
        public StatusResult<TucSubject> DeleteSubject([FromBody] TucSubject model)
        {

            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1) // ADMIN or teacher
            {
                rslt = SpCall.ManageSubject(model, "D");
            }
            else
            {
                rslt.Message = "This user has no permission to delete class.";
            }

            return rslt;
        }


        //   public static StatusResult<TucClassSubjectMap> ClassSubjectMap(TucClassSubjectMap model , string p_activity)

        [HttpPost]
        [Route("api/Subject/ClassSubjectMap")]
        public StatusResult<TucClassSubjectMap> ClassSubjectMap([FromBody] TucClassSubjectMap model)
        {

            StatusResult<TucClassSubjectMap> rslt = new StatusResult<TucClassSubjectMap>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1) // ADMIN 
            {
                rslt = SpCall.ClassSubjectMap(model, "I");
            }
            else
            {
                rslt.Message = "This user has no permission to class subject mapping.";
            }

            return rslt;
        }


        [HttpPost]
        [Route("api/Subject/ClassSubjectMapRemove")]
        public StatusResult<TucClassSubjectMap> ClassSubjectMapRemove([FromBody] TucClassSubjectMap model)
        {

            StatusResult<TucClassSubjectMap> rslt = new StatusResult<TucClassSubjectMap>();
            var checkSession = SysManageRepository.CheckSession(model.make_by, model.Session);

            if (checkSession.Status == "FAILED")
            {
                rslt.Status = checkSession.Status;
                rslt.Message = checkSession.Message;
                return rslt;
            }

            if (checkSession.Result.RoleId == 1) // ADMIN 
            {
                rslt = SpCall.ClassSubjectMap(model, "D");
            }
            else
            {
                rslt.Message = "This user has no permission to delete class subject mapping.";
            }

            return rslt;
        }

    }
}