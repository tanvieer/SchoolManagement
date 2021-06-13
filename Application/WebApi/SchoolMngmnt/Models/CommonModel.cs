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
        public string make_by { get; set; } 
    }
}