using SchoolMgmt.Model;
using SchoolMgmt.Model.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SchoolMgmt.Repository
{
    public class SysManageRepository
    {
        public SYS_USER_MASTER GetUserInfo(UserViewModel model)
        {
            SYS_USER_MASTER user = new SYS_USER_MASTER();
            user.Email = "tanvieer@gmail.com";
            user.Id = "123";
            user.UserName = "tanvieer";
            user.EncKey = "123";
            user.MakerTime = Convert.ToDateTime("24-Aug-1993");
            user.P_OUT = 0;
            return user;
        }

        public SYS_USER_MASTER RegisterUser(UserViewModel model)
        {
            SYS_USER_MASTER user = new SYS_USER_MASTER();
            return user;
        }
    }

}
