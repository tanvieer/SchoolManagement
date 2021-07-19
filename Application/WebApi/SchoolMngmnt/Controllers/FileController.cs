using Microsoft.VisualBasic.FileIO;
using SchoolMgmt.Repository;
using SchoolMngmnt.Model;
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
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;

namespace SchoolMngmnt.Controllers
{
    public class FileController : ApiController
    { 

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [Route("api/File/Post")]
        public StatusResult<List<ResultViewModel>> Post(string token)
        {
            StatusResult<List<ResultViewModel>> rslt = new StatusResult<List<ResultViewModel>>();
            ResultViewModel model = new ResultViewModel();
            rslt.Result = new List<ResultViewModel>();
            var httpRequest = HttpContext.Current.Request;
            var file = httpRequest.Files["File"];
            StatusResult<string> tmp;

            if (string.IsNullOrEmpty(token))
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


                    tmp = SysManageRepository.CheckIsActive(fieldData[0], 1);

                    if (tmp.Status == "FAILED")
                    {
                        rslt.Status = tmp.Status;
                        rslt.Message = tmp.Message;
                        return rslt;
                    }

                    tmp = SysManageRepository.CheckIsActive(fieldData[1], 2);

                    if (tmp.Status == "FAILED")
                    {
                        rslt.Status = tmp.Status;
                        rslt.Message = tmp.Message;
                        return rslt;
                    }

                    model = new ResultViewModel();

                    model.TestId = fieldData[1];
                    try
                    {
                        model.Grade = 0;
                        model.Grade = Convert.ToDouble(fieldData[2]);
                        model.StudentId = fieldData[0];
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


            
          


            rslt = SpCall.ManageResult(rslt.Result, checkSession.Result.UserName);

            return rslt;
        }











        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [Route("api/File/Get")]
        [HttpGet]
        public HttpResponseMessage Get(int id)
        {
            MemoryStream stream = new MemoryStream();
            StreamWriter writer = new StreamWriter(stream);


            List<UserMaster> students = SysManageRepository.GetStudentListByTestId(id).Result;
            writer.WriteLine("StudentID, TestId,Grade"); 
          //  writer.Flush();
            foreach (UserMaster std in students)
            {
                writer.WriteLine(std.UserName+", "+id+",");
                
            }
             writer.Flush();
           
            
            stream.Position = 0;

            HttpResponseMessage result = new HttpResponseMessage(HttpStatusCode.OK);
            result.Content = new StreamContent(stream);
            result.Content.Headers.ContentType = new MediaTypeHeaderValue("text/csv");
            result.Content.Headers.ContentDisposition = new ContentDispositionHeaderValue("attachment") { FileName = "Export.csv" };
            return result;
        }
    }
}
