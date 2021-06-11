using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DentalBackend.Models
{
    public class JwtPacket
    {
        public string Token { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email {get; set; }
        public int RoleId { get; set; }
    }
}
