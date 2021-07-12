using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchoolMngmnt.Models.ViewModel
{
    public class RouterLinkViewModel
    {
        public int Id { get; set; }
        public string RouterLink { get; set; }
        public string RouterName { get; set; } 
        public int RoleId { get; set; } 
        public int   IsSubMenu { get; set; }  
        public string ModuleName { get; set; }   
    }
}