
using Leadsoft.DAL;
using SchoolMngmnt.Model;
using SchoolMngmnt.Model.SysModel;
using SchoolMngmnt.Model.ViewModel;
using SchoolMngmnt.Models.ViewModel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common; 

namespace SchoolMgmt.Repository
{
    public static class SysManageRepository
    {
        private static readonly string SP_PREFIX = ConfigurationManager.AppSettings["SP_PREFIX"].ToString();
      
        // user insert update
        public static StatusResult<UserMaster> ManageUser(UserViewModel model,string p_activity,string makeBy)
        {
               
            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);
            int p_out = 0;

            StatusResult<UserMaster> rslt = new StatusResult<UserMaster>();
            List<DSSQLParam> objList = new List<DSSQLParam>(); 

            try
            { 
                objList.Add(new DSSQLParam("p_activity", p_activity, ParameterDirection.Input));
                objList.Add(new DSSQLParam("p_username", model.UserName, ParameterDirection.Input));
                objList.Add(new DSSQLParam("p_first_name", model.FirstName, ParameterDirection.Input));
                objList.Add(new DSSQLParam("p_last_name", model.LastName, ParameterDirection.Input));
                objList.Add(new DSSQLParam("p_email", model.Email, ParameterDirection.Input));
                objList.Add(new DSSQLParam("p_phone_number", model.PhoneNumber, ParameterDirection.Input));
                objList.Add(new DSSQLParam("p_password", model.Password, ParameterDirection.Input));
                objList.Add(new DSSQLParam("p_role_id", model.RoleId, ParameterDirection.Input));
                objList.Add(new DSSQLParam("p_class_id", model.ClassId, ParameterDirection.Input));
                objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input)); 
                objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
                objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
                objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));

                objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_tuc_sys_user_mast_i", CommandType.StoredProcedure, objList);
                p_out = Convert.ToInt32(objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString());
                if (p_out== 1)
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

            return rslt;
        }

        // login
        public static StatusResult<UserMaster> VerifyUser(LoginViewModel model)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }
            StatusResult<UserMaster> rslt = new StatusResult<UserMaster>();

            var user = new UserMaster
            {
                UserName = model.UserName.ToLower()
            };
            string p_out = "1";
            string err_code, err_msg;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_username", model.UserName, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_password", model.Password, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));
             

            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_sys_verify_user", CommandType.StoredProcedure, objList))
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
                     
                    while (dr.Read())
                    {
                        user.Id             = dr["ID"].ToString();
                        user.FirstName      = dr["FIRST_NAME"].ToString();
                        user.LastName       = dr["LAST_NAME"].ToString();
                        user.PhoneNumber    = dr["PHONE_NUMBER"].ToString();
                        user.UserName       = dr["USERNAME"].ToString();
                        user.Email          = dr["EMAIL"].ToString();
                        user.RoleId         = Convert.ToInt32(dr["ROLE_ID"].ToString());
                        user.RoleName       = dr["ROLE_NAME"] == null ? "" : dr["ROLE_NAME"].ToString();
                        user.Session        = dr["session_id"].ToString();
                        user.SessionExpireTime = Convert.ToDateTime(dr["session_exp_time"].ToString());
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
            rslt.Result = user;
            return rslt;
        }
    
        // to check session
        public static StatusResult<UserMaster> CheckSession(string sessionId)
        {
            StatusResult<UserMaster> rslt = new StatusResult<UserMaster>();
            rslt.Result = new UserMaster();


            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_session_id", sessionId, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_username", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_role_name", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("id", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));
             

            try
            {
                objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_check_session", CommandType.StoredProcedure, objList);
                
                rslt.Status          = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString() == "0" ? "SUCCESS" : "FAILED";
                

                if (rslt.Status == "FAILED")
                {
                    rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                } 
                else
                {
                    rslt.Result.UserName = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_username")] == null ? "" : objDbCommand.Parameters[CParameter.GetOutputParameterName("p_username")].Value.ToString();
                    rslt.Result.RoleName = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_role_name")] == null ? "" :  objDbCommand.Parameters[CParameter.GetOutputParameterName("p_role_name")].Value.ToString();
                    rslt.Result.Id = objDbCommand.Parameters[CParameter.GetOutputParameterName("id")] == null ? "" : objDbCommand.Parameters[CParameter.GetOutputParameterName("id")].Value.ToString();

                    if (rslt.Result.RoleName == "ADMIN")
                    {
                        rslt.Result.RoleId = 1;
                    }
                    else if (rslt.Result.RoleName == "TEACHER")
                    {
                        rslt.Result.RoleId = 2;
                    }
                    else rslt.Result.RoleId = 3;
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

        //to get single user information
        public static StatusResult< UserMaster> GetUserInfo(string userName, string p_session)
        {
            StatusResult<UserMaster> rslt = new StatusResult<UserMaster>();
            rslt.Result = new UserMaster
            {
                UserName = userName.ToLower()
            };
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);
             

            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_username", userName, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_session", p_session, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));
              


            try {  
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_tuc_sys_user_mast_gk", CommandType.StoredProcedure, objList))
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
                        rslt.Result.Id          = dr["ID"].ToString();
                        rslt.Result.FirstName   = dr["FIRST_NAME"].ToString();
                        rslt.Result.LastName    = dr["LAST_NAME"].ToString();
                        rslt.Result.PhoneNumber = dr["PHONE_NUMBER"].ToString();
                        rslt.Result.Email       = dr["EMAIL"].ToString();
                        rslt.Result.ClassId     = dr["CLASS_ID"].ToString();
                        rslt.Result.RoleId      = Convert.ToInt32(dr["ROLE_ID"].ToString());
                        rslt.Result.RoleName    = dr["ROLE_NAME"] == null ? "" : dr["ROLE_NAME"].ToString(); 
                        rslt.Result.AverageGrade = dr["avg_grade"] == null ? 0 : Convert.ToDouble(dr["avg_grade"].ToString());
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
       
        // to get user list by role
        public static StatusResult<List<UserMaster>> GetUserList(int userType, string p_session, string makeBy)
        {
            StatusResult<List<UserMaster>> rslt = new StatusResult<List<UserMaster>>();
            UserMaster user;
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);
             

            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_user_type", userType.ToString(), ParameterDirection.Input)); 
            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input)); 
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));
              


            try {  
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_tuc_sys_user_mast_ga", CommandType.StoredProcedure, objList))
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
                        rslt.Message =  objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    }

                    rslt.Result = new List<UserMaster>();
                    while (dr.Read())
                    {
                        user = new UserMaster();  
                        user.Id              = dr["ID"].ToString();
                        user.UserName        = dr["USERNAME"].ToString();
                        user.FirstName       = dr["FIRST_NAME"].ToString(); 
                        user.LastName        = dr["LAST_NAME"].ToString();
                        user.PhoneNumber     = dr["PHONE_NUMBER"].ToString();
                        user.Email           = dr["EMAIL"].ToString();
                        user.RoleId          = Convert.ToInt32(dr["ROLE_ID"].ToString());
                        user.ClassId         = dr["CLASS_ID"] == null ? "" : dr["CLASS_ID"].ToString();
                        user.ClassName       = dr["CLASS_NAME"] == null ? "" : dr["CLASS_NAME"].ToString();
                        user.RoleName        = dr["ROLE_NAME"] == null ? "" : dr["ROLE_NAME"].ToString();
                        user.AverageGrade    = dr["avg_grade"] == null ? 0 : Convert.ToDouble(dr["avg_grade"].ToString());

                        rslt.Result.Add(user);
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


        // to get user list by class id
        public static StatusResult<List<UserMaster>> GetStudentListByClassId(int classId, string makeBy)
        {
            StatusResult<List<UserMaster>> rslt = new StatusResult<List<UserMaster>>();
            UserMaster user;
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
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_get_std_by_class", CommandType.StoredProcedure, objList))
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

                    rslt.Result = new List<UserMaster>();
                    while (dr.Read())
                    {
                        user = new UserMaster();
                        user.Id = dr["ID"].ToString();
                        user.UserName = dr["USERNAME"].ToString();
                        user.FirstName = dr["FIRST_NAME"].ToString();
                        user.LastName = dr["LAST_NAME"].ToString();
                        user.PhoneNumber = dr["PHONE_NUMBER"].ToString();
                        user.Email = dr["EMAIL"].ToString();
                        user.RoleId = Convert.ToInt32(dr["ROLE_ID"].ToString());
                        user.ClassId = dr["CLASS_ID"] == null ? "" : dr["CLASS_ID"].ToString();
                        user.ClassName = dr["CLASS_NAME"] == null ? "" : dr["CLASS_NAME"].ToString();
                        user.RoleName = dr["ROLE_NAME"] == null ? "" : dr["ROLE_NAME"].ToString();
                        user.AverageGrade = dr["avg_grade"] == null ? 0 : Convert.ToDouble(dr["avg_grade"].ToString());

                        rslt.Result.Add(user);
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




        // to get GetRouterLinks
        public static StatusResult<List<RouterLinkViewModel>> GetRouterLinks(string makeBy)
        {
            StatusResult<List<RouterLinkViewModel>> rslt = new StatusResult<List<RouterLinkViewModel>>();
            RouterLinkViewModel model;
            string p_out = "1";
            string err_code;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();

             
            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));



            try
            {
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_tuc_menu_ga", CommandType.StoredProcedure, objList))
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

                    rslt.Result = new List<RouterLinkViewModel>();
                    while (dr.Read())
                    {
                        model = new RouterLinkViewModel();
                        model.Id            = Convert.ToInt32(dr["ID"].ToString());
                        model.RouterLink    = dr["router_link"].ToString();
                        model.RouterName    = dr["router_name"].ToString();
                        model.RoleId        = Convert.ToInt32(dr["role_id"].ToString());
                        model.IsSubMenu     = Convert.ToInt32(dr["is_sub_menu"].ToString());
                        model.ModuleName    = dr["module_name"].ToString();
                         
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




        // to reset password
        public static StatusResult<string> ResetPassword(string userName, string passWord , string makeBy)
        {
            StatusResult<string> rslt = new StatusResult<string>();


            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_username", userName, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_password", passWord, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out_email", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_user_id", makeBy, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));


            try
            {
                objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_sys_reset_password", CommandType.StoredProcedure, objList);

                rslt.Status = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString() == "0" ? "SUCCESS" : "FAILED";
                rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                if (rslt.Status == "SUCCESS")
                { 
                    rslt.Result = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out_email")].Value.ToString();
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

        // to change password
        public static StatusResult<string> ChangePassword(string userName, string oldPassword, string newPassword)
        {
            StatusResult<string> rslt = new StatusResult<string>();
             
            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();
             
            objList.Add(new DSSQLParam("p_username", userName, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_password_old", oldPassword, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_password_new", newPassword, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_user_id", userName, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));
             
            try
            {
                objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_sys_change_password", CommandType.StoredProcedure, objList);

                rslt.Status = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString() == "0" ? "SUCCESS" : "FAILED";
                rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                  
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



        /*sp_check_active*/


        // to reset password
        public static StatusResult<string> CheckIsActive(string p_value, int p_in) //p_in 1 = user check// 
        {
            StatusResult<string> rslt = new StatusResult<string>();


            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);


            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_in", p_in, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_value", p_value, ParameterDirection.Input)); 
            objList.Add(new DSSQLParam("p_out", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", string.Empty, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", string.Empty, ParameterDirection.Output));


            try
            {
                objCDataAccess.ExecuteNonQuery(objDbCommand, SP_PREFIX + "pkg_tuc_user_mast.sp_check_active", CommandType.StoredProcedure, objList);

                rslt.Status = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString() == "0" ? "SUCCESS" : "FAILED";
                rslt.Message = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                rslt.Result = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
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
