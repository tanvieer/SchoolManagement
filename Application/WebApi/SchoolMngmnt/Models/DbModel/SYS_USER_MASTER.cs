using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SchoolMngmnt.Model
{
    public class SYS_USER_MASTER
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
        public string Status { get; set; }
        public string MakerId { get; set; }
        public string LastUpdateBy { get; set; }
        public string RoleName { get; set; } 
        public string FullName { get { return this.FirstName + " " + this.LastName; } }

        public int P_OUT { get; set; }
        public string ErrorCode { get; set; }
        public string ErrorMsg { get; set; }
         

    }
}
 