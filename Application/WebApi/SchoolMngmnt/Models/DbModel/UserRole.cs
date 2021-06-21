using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchoolMngmnt.Models.DbModel
{
    public class UserRole   
    {
        public string RoleId { get; set; }
        public string RoleName { get; set; }
        public string RoleDescription { get; set; } 
        public string Status { get; set; } 

    }
}