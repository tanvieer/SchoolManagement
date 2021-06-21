using SchoolMngmnt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SchoolMngmnt.Model
{
    public class UserMaster : CommonModel
    {
        public string Id { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; } 
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNumber { get; set; } 
        public DateTime MakerTime { get; set; }
        public DateTime LastUpdateTime { get; set; }
        public int RoleId { get; set; }
        public string EncKey { get; set; } 
        public string MakerId { get; set; }
        public string ClassId { get; set; } 
        public string LastUpdateBy { get; set; } 
        public string FullName { get { return this.FirstName + " " + this.LastName; } } 

    }
}
 