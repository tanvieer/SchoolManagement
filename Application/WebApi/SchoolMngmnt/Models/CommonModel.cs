using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchoolMngmnt.Models
{
    public class CommonModel
    {
        public string Session { get; set; } 
        public DateTime SessionExpireTime { get; set; } 
        public string RoleName { get; set; }
        public int P_OUT { get; set; }
        public string ErrorCode { get; set; }
        public string ErrorMsg { get; set; }
    }
}