﻿using Microsoft.VisualBasic.FileIO;
using SchoolMgmt.Repository;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Models.ViewModel;
using SchoolMngmnt.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;

namespace SchoolMngmnt.Controllers
{
    public class ResultController : ApiController
    {
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/Result/AddNewResult")]
        public StatusResult<ResultViewModel> AddNewResult([FromBody] ResultViewModel model)
        {

            StatusResult<ResultViewModel> rslt = new StatusResult<ResultViewModel>();
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

            if (checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.ManageResult(model, "I", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to add result.";
            }

            return rslt;
        }



        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        [Route("api/Result/EditResult")]
        public StatusResult<ResultViewModel> EditResult([FromBody] ResultViewModel model)
        {

            StatusResult<ResultViewModel> rslt = new StatusResult<ResultViewModel>();
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

            if (checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                rslt = SpCall.ManageResult(model, "U", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to modify result.";
            }

            return rslt;
        }



        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Result/GetResultInfo")]
        public StatusResult<ResultViewModel> GetResultInfo(string id)
        {

            StatusResult<ResultViewModel> rslt = new StatusResult<ResultViewModel>();
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

            if (checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                ResultViewModel model = new ResultViewModel();
                model.ResultId = id;
                rslt = SpCall.GetResultInfo(id, checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to view result.";
            }

            return rslt;
        }





        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpDelete]
        [Route("api/Result/DeleteResult")]
        public StatusResult<ResultViewModel> DeleteResult(string id)
        {

            StatusResult<ResultViewModel> rslt = new StatusResult<ResultViewModel>();
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

            if (checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                ResultViewModel model = new ResultViewModel();
                model.ResultId = id;
                rslt = SpCall.ManageResult(model, "D", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to delete result.";
            }

            return rslt;
        }




        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpDelete]
        [Route("api/Result/ArchiveResult")]
        public StatusResult<ResultViewModel> ArchiveResult(string id)
        {

            StatusResult<ResultViewModel> rslt = new StatusResult<ResultViewModel>();
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

            if (checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                ResultViewModel model = new ResultViewModel();
                model.ResultId = id;
                rslt = SpCall.ManageResult(model, "A", checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to archive result.";
            }

            return rslt;
        }



        //GetResultByTest

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        [Route("api/Result/GetResultListByTestId")]
        public StatusResult<List<ResultViewModel>> GetResultListByTestId(string id)
        {

            StatusResult<List<ResultViewModel>> rslt = new StatusResult<List<ResultViewModel>>();
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

            if (checkSession.Result.RoleId == 2) // ADMIN or teacher
            {
                ResultViewModel model = new ResultViewModel();
                model.ResultId = id;
                rslt = SpCall.GetResultByTest(id, checkSession.Result.UserName);
            }
            else
            {
                rslt.Message = "This user has no permission to view result.";
            }

            return rslt;
        }

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [Route("api/File/Post")]
        public StatusResult<List<ResultViewModel>> UploadFile()
        {
            StatusResult<List<ResultViewModel>> rslt = new StatusResult<List<ResultViewModel>>();
            ResultViewModel model = new ResultViewModel();
            rslt.Result = new List<ResultViewModel>();
            var httpRequest = HttpContext.Current.Request;
            var file = httpRequest.Files["File"];


            DataTable csvDataTable = new DataTable();

            // Read bytes from http input stream
            var csvBody = string.Empty;

            using (BinaryReader b = new BinaryReader(file.InputStream))
            {
                byte[] binData = b.ReadBytes(file.ContentLength);
                csvBody = Encoding.UTF8.GetString(binData);
            }

            var memoryStream = new MemoryStream();
            var streamWriter = new StreamWriter(memoryStream);
            streamWriter.Write(csvBody);
            streamWriter.Flush();
            memoryStream.Position = 0;

            using (TextFieldParser csvReader = new TextFieldParser(memoryStream))
            {
                csvReader.SetDelimiters(new string[] { "," });
                csvReader.HasFieldsEnclosedInQuotes = true;
                string[] colFields = csvReader.ReadFields();
                foreach (string column in colFields)
                {
                    DataColumn datecolumn = new DataColumn(column);
                    datecolumn.AllowDBNull = true;
                    csvDataTable.Columns.Add(datecolumn);
                }
                while (!csvReader.EndOfData)
                {
                    string[] fieldData = csvReader.ReadFields();
                    //Making empty value as null
                    for (int i = 0; i < fieldData.Length; i++)
                    {
                        if (fieldData[i] == "")
                        {
                            fieldData[i] = null;
                        }
                    }
                    model = new ResultViewModel();

                    model.TestId = fieldData[0];
                    try
                    {
                        model.Grade = 0;
                        model.Grade = Convert.ToDouble(fieldData[1]);
                        model.StudentId = fieldData[2];
                    }
                    catch (Exception ex)
                    {
                        rslt.Status = "FAILED";
                        rslt.Message = ex.Message;
                        return rslt;
                    }

                    rslt.Result.Add(model);

                    // csvDataTable.Rows.Add(fieldData);
                }
            }
            rslt.Status = "SUCCESS";

            rslt = SpCall.ManageResult(rslt.Result, "t");

            return rslt;
        }


    }
}
