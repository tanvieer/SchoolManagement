
using Leadsoft.DAL;
using SchoolMngmnt.Model;
using SchoolMngmnt.Model.ViewModel;
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
      

        public static UserMaster RegisterUser(UserViewModel model)
        {
            UserMaster user = new UserMaster
            {
                Email        = "tanvieer@gmail.com",
                Id           = "123",
                UserName     = model.UserName.ToLower().Trim(),
                EncKey       = "123",
                MakerTime    = Convert.ToDateTime("24-Aug-1993"),
                P_OUT        = 0
            };
            return user;
        }

        public static UserMaster VerifyUser(LoginViewModel model)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            var user = new UserMaster
            {
                UserName = model.UserName.ToUpper()
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
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_user_master.sp_sys_verify_user", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1") err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();

                    err_msg = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();
                    user.ErrorMsg = err_msg;
                    while (dr.Read())
                    {
                        user.Id = dr["ID"].ToString();
                        user.FirstName = dr["FIRST_NAME"].ToString();
                        user.LastName = dr["LAST_NAME"].ToString();
                        user.PhoneNumber = dr["PHONE_NUMBER"].ToString();
                        user.Email = dr["EMAIL"].ToString();
                        user.RoleId = Convert.ToInt32(dr["ROLE_ID"].ToString());
                        user.RoleName = dr["ROLE_NAME"] == null ? "" : dr["ROLE_NAME"].ToString();
                        user.Session = dr["session_id"].ToString();
                        user.SessionExpireTime = Convert.ToDateTime(dr["session_exp_time"].ToString());
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                user.ErrorMsg = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return user;
        }
    

         


        public static UserMaster GetUserInfo(string userName)
        {
            var user = new UserMaster
            {
                UserName = userName.ToUpper()
            };
            string p_out = "1";
            string err_code, err_msg;

            CDataAccess objCDataAccess = CDataAccess.NewCDataAccess();
            DbCommand objDbCommand = objCDataAccess.GetMyCommand(false, IsolationLevel.ReadCommitted, "application", false);
             

            List<DSSQLParam> objList = new List<DSSQLParam>();


            objList.Add(new DSSQLParam("p_username", userName, ParameterDirection.Input));
            objList.Add(new DSSQLParam("p_out", userName, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_code", userName, ParameterDirection.Output));
            objList.Add(new DSSQLParam("p_err_msg", userName, ParameterDirection.Output));
             
             
         


            try {  
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_user_master.sp_UserMaster_gk", CommandType.StoredProcedure, objList))
                {
                    p_out = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_out")].Value.ToString();
                    if (p_out == "1")  err_code = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_code")].Value.ToString();
                    
                    err_msg = objDbCommand.Parameters[CParameter.GetOutputParameterName("p_err_msg")].Value.ToString();

                    while (dr.Read())
                    { 
                        user.Id          = dr["ID"].ToString();
                        user.FirstName   = dr["FIRST_NAME"].ToString(); 
                        user.LastName    = dr["LAST_NAME"].ToString();
                        user.PhoneNumber = dr["PHONE_NUMBER"].ToString();
                        user.Email       = dr["EMAIL"].ToString();
                        user.RoleId      = Convert.ToInt32(dr["ROLE_ID"].ToString());
                        user.RoleName    = dr["ROLE_NAME"] == null ? "" : dr["ROLE_NAME"].ToString(); 
                    }
                    dr.Close();
                } 
            }
            catch (Exception ex)
            {
                user.ErrorMsg = ex.Message;
            }
            finally
            {
                objDbCommand.Connection.Close();
                objCDataAccess.Dispose(objDbCommand);
                objList.Clear();
            }
            return user;
        }
         
    }
}
