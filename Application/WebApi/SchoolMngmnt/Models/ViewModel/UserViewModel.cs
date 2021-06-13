using SchoolMngmnt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SchoolMngmnt.Model.ViewModel
{
    public class UserViewModel : CommonModel
    {
        public string Id { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; } 
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNumber { get; set; } 
        public int RoleId { get; set; } 
        public string FullName { get { return this.FirstName + " " + this.LastName; } }
    }
}
