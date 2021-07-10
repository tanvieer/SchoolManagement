using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchoolMngmnt.Models.ViewModel
{
    public class ChangePasswordViewModel
    {
        
        public string UserName { get; set; }
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }

    }
}