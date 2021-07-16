using Leadsoft.DAL;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Models.DbModel;
using SchoolMngmnt.Models.ViewModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;

namespace SchoolMngmnt.Repository
{
    public class SpCall
    {
        private static readonly string SP_PREFIX = ConfigurationManager.AppSettings["SP_PREFIX"].ToString();

         

        public static StatusResult<TucClass> ManageClass(TucClass model, string p_activity , string makeBy)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            StatusResult<TucClass> rslt = new StatusResult<TucClass>();
            rslt.Result = new TucClass();

            int p_out = 1; 

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();

            objList.Clear();
            objList.Add(new DSSQLParam("p_activity", p_activity, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_class_id", model.ClassId ?? "", ParameterDirection.InputOutput));
            objList.Add(new DSSQLParam("p_class_name", model.ClassName, ParameterDirection.Input)); 
            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));
             


            try
            {
                objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_class", CommandType.StoredProcedure, objList);

                p_out = Convert.ToInt32(objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString());
                if (p_out == 1)
                {
                    rslt.Status = "FAILED";
                    rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString()
                        + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                }
                else
                {
                    rslt.Status = "SUCCESS";
                    rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            rslt.Result = model;
            return rslt;
        }


        public static StatusResult<TucSubject> ManageSubject(TucSubject model, string p_activity,string makeBy)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();

            rslt.Result = new TucSubject();

            int p_out = 1;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_activity", p_activity, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_subject_id", model.SubjectId, ParameterDirection.InputOutput));
            objList.Add(new DSSQLParam("p_class_id", model.ClassId, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_subject_name", model.SubjectName, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_teacher_id", model.TeacherUserName, ParameterDirection.Input)); 

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));




            try
            {
                objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_subject", CommandType.StoredProcedure, objList);

                p_out = Convert.ToInt32(objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString());
                if (p_out == 1)
                {
                    rslt.Status = "FAILED";
                    rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString()
                        + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                }
                else
                {
                    rslt.Status = "SUCCESS";
                    rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
             
            rslt.Result = model;
            return rslt;
        }




        public static StatusResult<TucClass> GetClassInfo(string classId, string makeBy)
        {
            StatusResult<TucClass> rslt = new StatusResult<TucClass>();
            rslt.Result = new TucClass();
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_class_id", classId, ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_class_gk", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }

                    while (dr.Read())
                    {
                        rslt.Result.ClassId =  dr["class_id"].ToString();
                        rslt.Result.ClassName = dr["class_name"].ToString();                       
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            } 
            return rslt;
        }



        public static StatusResult<TucSubject> GetSubjectInfo(string subjectId, string makeBy)
        {
            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();
            rslt.Result = new TucSubject();
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_subject_id", subjectId, ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));
             


            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_subject_gk", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }

                    while (dr.Read())
                    {
                        rslt.Result.SubjectId = dr["subject_id"].ToString();
                        rslt.Result.SubjectName = dr["subject_name"].ToString();
                        rslt.Result.TeacherId = dr["teacher_id"].ToString();
                        rslt.Result.TeacherUserName = dr["teacher_username"].ToString();
                        rslt.Result.TeacherName = dr["teacher_full_name"].ToString();
                        rslt.Result.ClassId = dr["class_id"].ToString();
                        rslt.Result.ClassName = dr["class_name"].ToString();
                        rslt.Result.Status = dr["status"].ToString();
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            } 
            return rslt;
        }

         
        public static StatusResult<List<TucClass>> GetClassList(string makeBy)
        {
            StatusResult<List<TucClass>> rslt = new StatusResult<List<TucClass>>();
            TucClass model;
            rslt.Result = new List<TucClass>();
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_in", "1", ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_class_ga", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Status = "FAILED";
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }


                    while (dr.Read())
                    {
                        model = new TucClass();
                        model.ClassId = dr["class_id"].ToString();
                        model.ClassName = dr["class_name"].ToString(); 

                        rslt.Result.Add(model);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return rslt;
        }



        public static StatusResult<List<TucSubject>> GetSubjectList(string makeBy, string classId, int p_in)
        {
            StatusResult<List<TucSubject>> rslt = new StatusResult<List<TucSubject>>();
            rslt.Result = new List<TucSubject>();
            TucSubject model = new TucSubject();
            string p_out = "1";
            string err_code, err_msg;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();
             


            objList.Add(new DSSQLParam("p_in", p_in, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_class_id", classId, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_subject_ga", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Status = "FAILED";
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        err_msg = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }


                    while (dr.Read())
                    {
                        model = new TucSubject();
                        model.SubjectId = dr["subject_id"].ToString();
                        model.SubjectName = dr["subject_name"].ToString();
                        model.TeacherId = dr["teacher_id"].ToString();
                        model.TeacherUserName = dr["teacher_username"].ToString();
                        model.ClassId = dr["class_id"].ToString();
                        model.ClassName = dr["class_name"].ToString();
                        model.TeacherName = dr["teacher_full_name"].ToString();
                        model.Status = dr["status"].ToString();

                        rslt.Result.Add(model);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return rslt;
        }





    /****************************************/



        public static StatusResult<TestViewModel> ManageTest(TestViewModel model, string p_activity, string makeBy)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            StatusResult<TestViewModel> rslt = new StatusResult<TestViewModel>();
            rslt.Result = new TestViewModel();

            int p_out = 1;
             

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>(); 
             

            objList.Add(new DSSQLParam("p_activity", p_activity, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_test_id", model.TestId, ParameterDirection.InputOutput));
            objList.Add(new DSSQLParam("p_test_name", model.TestName, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_subject_id", model.SubjectId, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_test_date", model.TestDate, ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));

            try
            {
                objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_test", CommandType.StoredProcedure, objList);

                p_out = Convert.ToInt32(objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString());
                if (p_out == 1)
                {
                    rslt.Status = "FAILED";
                    rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString()
                        + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                }
                else
                {
                    rslt.Status = "SUCCESS";
                    rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            rslt.Result = model;
            return rslt;
        }



        public static StatusResult<TucTest> GetTestInfo(string TestId, string makeBy)
        {
            StatusResult<TucTest> rslt = new StatusResult<TucTest>();
            rslt.Result = new TucTest();
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();
             


            objList.Add(new DSSQLParam("p_test_id", TestId, ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_test_gk", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }

                    while (dr.Read())
                    {
                        rslt.Result.TestId = dr["test_id"].ToString();
                        rslt.Result.TestName = dr["test_name"].ToString();
                        rslt.Result.SubjectId = dr["subject_id"].ToString();
                        rslt.Result.SubjecName = dr["subject_name"].ToString();
                        rslt.Result.Status = dr["status"].ToString();
                        rslt.Result.TestDateStr = dr["test_date"].ToString();
                         

                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return rslt;
        }



        public static StatusResult<List<TucTest>> GetTestList(string subjectId,string makeBy)
        {
            StatusResult<List<TucTest>> rslt = new StatusResult<List<TucTest>>();
            TucTest model;
            rslt.Result = new List<TucTest>();
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();
             

            objList.Add(new DSSQLParam("p_in", "1", ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_subject_id", subjectId, ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_test_ga", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Status = "FAILED";
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }


                    while (dr.Read())
                    {
                        model = new TucTest(); 

                        model.TestId = dr["test_id"].ToString();
                        model.TestName = dr["test_name"].ToString();
                        model.SubjectId = dr["subject_id"].ToString();
                        model.SubjecName = dr["subject_name"].ToString();
                        model.TestDateStr = dr["test_date"].ToString();

                        model.Status = dr["status"].ToString();

                       

                        rslt.Result.Add(model);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return rslt;
        }



        public static StatusResult<List<ResultViewModel>> GetResultByTest(string testId, string makeBy)
        {
            StatusResult<List<ResultViewModel>> rslt = new StatusResult<List<ResultViewModel>>();
            ResultViewModel model;
            rslt.Result = new List<ResultViewModel>();
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_test_id", testId, ParameterDirection.Input)); 

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_test_result_ga", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Status = "FAILED";
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }


                    while (dr.Read())
                    {
                        model = new ResultViewModel();

                        model.ResultId = dr["result_id"].ToString();
                        model.TestId = dr["test_id"].ToString();
                        model.TestName = dr["test_name"].ToString();
                        model.Grade = dr["grade"] == null ? 0 : Convert.ToDouble(dr["grade"].ToString());
                        model.Status = dr["status"].ToString();
                        model.StudentId = dr["student_id"].ToString();
                        model.Username = dr["username"].ToString();
                        model.FirstName = dr["first_name"].ToString();
                        model.LastName = dr["last_name"].ToString();
                        model.Status = dr["status"].ToString();

                        rslt.Result.Add(model);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return rslt;
        }


        public static StatusResult<ResultViewModel> GetResultInfo(string resultId, string makeBy)
        {
            StatusResult<ResultViewModel> rslt = new StatusResult<ResultViewModel>();
            rslt.Result = new ResultViewModel();
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_result_id", resultId, ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_result_gk", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }

                    while (dr.Read())
                    {
                        rslt.Result.ResultId = dr["result_id"].ToString();
                        rslt.Result.TestId = dr["test_id"].ToString();
                        rslt.Result.TestName = dr["test_name"].ToString();
                        rslt.Result.Grade = dr["grade"] == null ? 0 : Convert.ToDouble(dr["grade"].ToString());
                        rslt.Result.Status = dr["status"].ToString();
                        rslt.Result.StudentId = dr["student_id"].ToString();
                        rslt.Result.Username = dr["username"].ToString();
                        rslt.Result.FirstName = dr["first_name"].ToString();
                        rslt.Result.LastName = dr["last_name"].ToString();
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return rslt;
        }





        public static StatusResult<ResultViewModel> ManageResult(ResultViewModel model, string p_activity, string makeBy)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            StatusResult<ResultViewModel> rslt = new StatusResult<ResultViewModel>();

            rslt.Result = new ResultViewModel();

            int p_out = 1;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_activity", p_activity, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_result_id", model.ResultId, ParameterDirection.InputOutput));
            objList.Add(new DSSQLParam("p_test_id", model.TestId, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_grade", model.Grade, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_student_id", model.StudentId, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_save_status", "C", ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));




            try
            {
                objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_result", CommandType.StoredProcedure, objList);

                p_out = Convert.ToInt32(objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString());
                if (p_out == 1)
                {
                    rslt.Status = "FAILED";
                    rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString()
                        + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                }
                else
                {
                    rslt.Status = "SUCCESS";
                    rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                //if (save_status == "S")
                //{
                //    objDbCommand.Transaction.Rollback();
                //}
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                //if (save_status == "S")
                //{
                //    objDbCommand.Transaction.Commit();
                //}

                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();

               
            }

            rslt.Result = model;
            return rslt;
        }





        public static StatusResult<List<ResultViewModel>> ManageResult(List<ResultViewModel> itemList, string makeBy)
        {
            if (itemList is null)
            {
                throw new ArgumentNullException(nameof(itemList));
            }
            StatusResult<List<ResultViewModel>> rslt = new StatusResult<List<ResultViewModel>>();

            rslt.Result = new List<ResultViewModel>();
            ResultViewModel model;

            List<DSSQLParam> objList;

            int p_out = 1;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);

            try
            {


                foreach (ResultViewModel item in itemList)
                {
                    try
                    {
                        objList = new List<DSSQLParam>();
                        objList.Clear();

                        model = item;

                        objList.Add(new DSSQLParam("p_activity", "I", ParameterDirection.Input));
                        objList.Add(new DSSQLParam("p_result_id", item.ResultId, ParameterDirection.InputOutput));
                        objList.Add(new DSSQLParam("p_test_id", item.TestId, ParameterDirection.Input));
                        objList.Add(new DSSQLParam("p_grade", item.Grade, ParameterDirection.Input));
                        objList.Add(new DSSQLParam("p_student_id", item.StudentId, ParameterDirection.Input));
                        objList.Add(new DSSQLParam("p_save_status", "S", ParameterDirection.Input));

                        objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
                        objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
                        objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
                        objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output)); 

                        try
                        {
                            objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_result", CommandType.StoredProcedure, objList);

                            p_out = Convert.ToInt32(objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString());
                            if (p_out == 1)
                            {
                                rslt.Status = "FAILED";
                                rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString()
                                    + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                                model.ErrMsg = rslt.Message;

                                model.ResultId = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_result_id")] == null? null : objDbCommand.Parameters[CParameter.GetOutputParameterName("p_result_id")].Value.ToString();
                            }
                            else
                            {
                                model.ResultId = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_result_id")].Value.ToString();
                                rslt.Status = "SUCCESS";
                                rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();

                                model.ErrMsg = rslt.Message;
                            }

                            rslt.Result.Add(model);

                            objList.Clear();
                        }
                        catch (Exception ex)
                        { 
                            rslt.Status = "FAILED";
                            rslt.Message = ex.Message; 
                            break;
                        } 

                    }
                    catch (Exception ex)
                    { 
                        rslt.Status = "FAILED";
                        rslt.Message = ex.Message; 
                        break;
                    }

                }
            }
            catch (Exception ex)
            { 
                rslt.Status = "FAILED";
                rslt.Message = ex.Message; 
            }
            finally
            {
                 
                 
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand); 

            }


            return rslt;
        }





        public static StatusResult<List<StudentTestListViewModel>> GetTestListBySubject(string subject_id,string makeBy)
        {
            StatusResult<List<StudentTestListViewModel>> rslt = new StatusResult<List<StudentTestListViewModel>>();
            rslt.Result = new List<StudentTestListViewModel>();
            StudentTestListViewModel model;
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_subject_id", subject_id, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_student_id", makeBy, ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_result_by_subject", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }

                    while (dr.Read())
                    {
                        model = new StudentTestListViewModel();

                        model.TestId = dr["test_id"].ToString();
                        model.TestName = dr["test_name"].ToString();
                        model.SubjectId = dr["subject_id"].ToString();
                        model.Grade = dr["grade"] == null ? 0 : Convert.ToDouble(dr["grade"].ToString());
                        model.SubjectName = dr["subject_name"].ToString(); 
                         
                        rslt.Result.Add(model);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return rslt;
        }




        public static StatusResult<List<StudentSubjectListViewModel>> GetSubjectByStudentUserName(string makeBy)
        {
            StatusResult<List<StudentSubjectListViewModel>> rslt = new StatusResult<List<StudentSubjectListViewModel>>();
            rslt.Result = new List<StudentSubjectListViewModel>();
            StudentSubjectListViewModel model;
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_student_id", makeBy, ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_subjects_by_stdnt", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Message = err_code + "~" + objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                        return rslt;
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }

                    while (dr.Read())
                    {
                        model = new StudentSubjectListViewModel();

                        model.StudentId = dr["ID"].ToString();
                        model.SubjectId = dr["subject_id"].ToString();
                        model.SubjectName = dr["subject_name"].ToString();
                        model.AverageGrade = dr["avg_grade"] == null ? 0 : Convert.ToDouble(dr["avg_grade"].ToString());
                        model.FullName = dr["full_name"].ToString(); 
                        model.Username = dr["username"].ToString(); 
                        model.TestCount = dr["test_count"] == null ? 0 : Convert.ToInt32(dr["test_count"].ToString());


                        rslt.Result.Add(model);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                rslt.Status = "FAILED";
                rslt.Message = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return rslt;
        }





    }
}