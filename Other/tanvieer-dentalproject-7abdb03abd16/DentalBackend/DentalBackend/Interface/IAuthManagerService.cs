using DentalBackend.Models;
namespace DentalBackend.Interface
{
    public interface IAuthManagerService
    {
        LoginViewModel Login(LoginViewModel model);
        LoginViewModel Register(LoginViewModel model);
    }
}
