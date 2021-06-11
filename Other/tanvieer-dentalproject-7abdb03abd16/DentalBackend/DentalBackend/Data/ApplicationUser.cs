using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DentalBackend.Data
{
    public class ApplicationUser
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long Id { get; set; }
        [StringLength(450)]
        public string UserName { get; set; }
        [StringLength(450)]
        public string Password { get; set; }
        [StringLength(450)]
        public string Email { get; set; }

        [StringLength(150)]
        public string FirstName { get; set; }

        [StringLength(150)]
        public string LastName { get; set; }

        [StringLength(50)]
        public string PhoneNumber { get; set; }
        public int AccessFailedCount { get; set; }
        public bool EmailConfirmed { get; set; }
        [StringLength(4000)]
        public string PasswordHash { get; set; }
        public bool PhoneNumberConfirmed { get; set; }
        public bool TwoFactorEnabled { get; set; }
      
        [StringLength(450)]
        public string Details { get; set; }

        public DateTime RegistrationDate { get; set; }

        [NotMapped]
        public string FullName { get { return this.FirstName + " " + this.LastName; } }


    }
}
