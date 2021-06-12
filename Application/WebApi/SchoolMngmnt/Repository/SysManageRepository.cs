
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
      

        public static SYS_USER_MASTER VerifyUser(LoginViewModel model)
        {
            SYS_USER_MASTER user = new SYS_USER_MASTER
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

        public static SYS_USER_MASTER RegisterUser(UserViewModel model)
        {
            if (model is null)
            {
                throw new ArgumentNullException(nameof(model));
            }

            SYS_USER_MASTER user = new SYS_USER_MASTER();
            return user;
        }

         


        public static SYS_USER_MASTER GetUserInfo(String userName)
        {
            var user = new SYS_USER_MASTER
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
                using (DbDataReader dr = objCDataAccess.ExecuteReader(objDbCommand, SP_PREFIX + "pkg_user_master.sp_sys_user_master_gk", CommandType.StoredProcedure, objList))
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
                objDbCommand.Transaction.Rollback();
                throw ex;
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
