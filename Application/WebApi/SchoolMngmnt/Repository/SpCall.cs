using Leadsoft.DAL;
using SchoolMngmnt.Model;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Model.ViewModel;
using SchoolMngmnt.Models.DbModel;
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



        public static StatusResult<TucClassSubjectMap> ClassSubjectMap(TucClassSubjectMap model , string p_activity)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            StatusResult<TucClassSubjectMap> rslt = new StatusResult<TucClassSubjectMap>();

            
            string p_out = "1";
            string err_code, err_msg;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_activity", p_activity, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_subject_id", model.SubjectId, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_class_id", model.ClassId, ParameterDirection.Input));


            objList.Add(new DSSQLParam("p_user_id", model.make_by, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));


            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_class_subject_map", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    err_msg = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Message = err_code + "~" + err_msg;
                        rslt.Status = "FAILED";
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = err_msg;
                    }                     
                }
            }
            catch (Exception ex)
            {
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



        public static StatusResult<TucClass> ManageClass(TucClass model, string p_activity)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            StatusResult<TucClass> rslt = new StatusResult<TucClass>();


            string p_out = "1";
            string err_code, err_msg;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_activity", p_activity, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_class_id", model.ClassId, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_class_name", model.ClassName, ParameterDirection.Input)); 

            objList.Add(new DSSQLParam("p_user_id", model.make_by, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));


            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_class", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    err_msg = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Message = err_code + "~" + err_msg;
                        rslt.Status = "FAILED";
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = err_msg;
                    }
                }
            }
            catch (Exception ex)
            {
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


        public static StatusResult<TucSubject> ManageSubject(TucSubject model, string p_activity)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            StatusResult<TucSubject> rslt = new StatusResult<TucSubject>();


            string p_out = "1";
            string err_code, err_msg;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_activity", p_activity, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_subject_id", model.SubjectId, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_subject_name", model.SubjectName, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_teacher_id", model.TeacherId, ParameterDirection.Input));

            objList.Add(new DSSQLParam("p_user_id", model.make_by, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));


            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_manage_op.sp_tuc_subject", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    err_msg = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    if (p_out == "1")
                    {
                        err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                        rslt.Message = err_code + "~" + err_msg;
                        rslt.Status = "FAILED";
                    }
                    else
                    {
                        rslt.Status = "SUCCESS";
                        rslt.Message = err_msg;
                    }
                }
            }
            catch (Exception ex)
            {
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
            string p_out = "1";
            string err_code, err_msg;

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
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_tuc_class_gk", CommandType.StoredProcedure, objList))
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
                        rslt.Result.ClassId = dr["class_id"].ToString();
                        rslt.Result.ClassName = dr["class_name"].ToString();
                        rslt.Result.Status = dr["status"].ToString();                          
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
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
            string p_out = "1";
            string err_code, err_msg;

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
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_tuc_subject_gk", CommandType.StoredProcedure, objList))
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
                        rslt.Result.SubjectName = dr["teacher_id"].ToString();
                        rslt.Result.TeacherUserName = dr["teacher_username"].ToString();
                        rslt.Result.TeacherName = dr["teacher_full_name"].ToString();
                        rslt.Result.Status = dr["status"].ToString();
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
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
            string p_out = "1";
            string err_code, err_msg;

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
                        err_msg = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }


                    while (dr.Read())
                    {
                        model = new TucClass();
                        model.ClassId = dr["class_id"].ToString();
                        model.ClassName = dr["class_name"].ToString();
                        model.Status = dr["status"].ToString();
                         
                        model.RoleName = dr["ROLE_NAME"] == null ? "" : dr["ROLE_NAME"].ToString();

                        rslt.Result.Add(model);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
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



        public static StatusResult<List<TucSubject>> GetSubjectList(string makeBy)
        {
            StatusResult<List<TucSubject>> rslt = new StatusResult<List<TucSubject>>();
            TucSubject model;
            string p_out = "1";
            string err_code, err_msg;

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
                        model.TeacherName = dr["teacher_full_name"].ToString();
                        model.Status = dr["status"].ToString();

                        model.RoleName = dr["ROLE_NAME"] == null ? "" : dr["ROLE_NAME"].ToString();

                        rslt.Result.Add(model);
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
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