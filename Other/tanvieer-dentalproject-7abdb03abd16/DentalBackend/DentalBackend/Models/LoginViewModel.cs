using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DentalBackend.Models
{
    public class LoginViewModel
    {
        public long Id { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public bool RememberMe { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string PhoneNumber { get; set; }
        public string Details { get; set; }
        public DateTime RegistrationTime { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; }
        public string FullName { get { return this.FirstName + " " + this.LastName; } }

    }
}
