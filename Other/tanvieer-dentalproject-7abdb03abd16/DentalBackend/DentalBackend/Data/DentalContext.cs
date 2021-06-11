using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace DentalBackend.Data
{
    public class DentalContext : IdentityDbContext<User>
    {
        public DentalContext(DbContextOptions<DentalContext> options)
           : base(options)
        { }
        public DbSet<ApplicationUser> ApplicationUser { get; set; }
        public DbSet<ApplicationRole> ApplicationRole { get; set; }
        public DbSet<ApplicationUserRole> ApplicationUserRole { get; set; }

    }
}
