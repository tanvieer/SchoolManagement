using DentalBackend.Data;
using DentalBackend.Models;
using DentalBackend.Interface;
using System;
using System.Linq;
using Planteen.Utility;

namespace DentalBackend.Repository
{
    public class AuthManagerRepository : IAuthManagerService
    {
        readonly DentalContext context;
        public AuthManagerRepository(DentalContext context)
        {
            this.context = context;
        }

        public LoginViewModel Login(LoginViewModel model)
        {
            var userinfo = (from usr in context.ApplicationUser
                            where usr.UserName == model.UserName.Trim() 

                            select new LoginViewModel
                            {
                                Id = usr.Id,
                                UserName = model.UserName,
                                RegistrationTime = usr.RegistrationDate
                            }).FirstOrDefault(); // this is to get encryption key
            if (userinfo == null) return null;

            var user = (from usr in context.ApplicationUser
                        where usr.UserName == model.UserName.Trim() && usr.PasswordHash == EncryptDecrypt.EncryptString(model.Password, userinfo.RegistrationTime.ToString() + model.Password)

                        select new LoginViewModel
                        {
                            Id = usr.Id,
                            UserName = model.UserName,
                            FirstName = usr.FirstName,
                            LastName = usr.LastName,
                            Email = usr.Email,
                            PhoneNumber = usr.PhoneNumber,
                            RoleId = context.ApplicationUserRole.FirstOrDefault(it => it.Id == usr.Id).RoleId
                         }).FirstOrDefault();
            if (user == null) return null;
            var rolename = context.ApplicationRole.FirstOrDefault(it => it.RoleId == user.RoleId);
            user.RoleName = rolename == null ? "User" : rolename.RoleName;
            return user;
        }

        public LoginViewModel Register(LoginViewModel model)
        {
            model.RegistrationTime = DateTime.Now;
            LoginViewModel registerUser = new LoginViewModel();
            var user = new ApplicationUser {
                UserName = model.UserName,
                Password = model.Password,
                Email = model.Email,
                PhoneNumber = model.PhoneNumber,
                RegistrationDate = model.RegistrationTime,
                PhoneNumberConfirmed = false,
                FirstName = model.FirstName,
                LastName = model.LastName,
                TwoFactorEnabled = false,
                Details = model.Details,
                PasswordHash = EncryptDecrypt.EncryptString(model.Password, model.RegistrationTime.ToString() + model.Password)
            };
            context.ApplicationUser.Add(user);

           // ApplicationRole role = context.ApplicationRole.FirstOrDefault(it => it.Id == model.RoleId);
            //if (role == null)
                model.RoleId = 0; // normal user role;
            
            
            try
            {
                context.SaveChanges();
                ApplicationUserRole usrRole = new ApplicationUserRole
                {
                    UserId = user.Id,
                    RoleId = model.RoleId
                };
                context.ApplicationUserRole.Add(usrRole);
                context.SaveChanges();
                registerUser.Id = user.Id;
                registerUser.RoleId = usrRole.RoleId;
                registerUser.RoleName = "User";  //role.RoleName;
                registerUser.UserName = user.UserName;
                registerUser.FirstName = user.FirstName;
                registerUser.LastName = user.LastName;
                registerUser.Email = user.Email;
                return registerUser;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

           
        }
    }
}
