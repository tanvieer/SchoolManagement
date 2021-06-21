
using MassTransit.Serialization;
using SchoolMngmnt.Model;
using System;
using System.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text; 

namespace SchoolMngmnt.Controllers.Services
{
    public class UtilityService
    {

        private const string _alg = "HmacSHA256";
        private const string _salt = "rz8LuOtFBXphj9WQfvFh";

        public string GenerateToken(string username, string password, string ip, string userAgent, long ticks)
        {
            string hash = string.Join(":", new string[] { username, ip, userAgent, ticks.ToString() });
            string hashLeft = "";
            string hashRight = "";
            using (HMAC hmac = HMACSHA256.Create(_alg))
            {
                hmac.Key = Encoding.UTF8.GetBytes(GetHashedPassword(password));
                hmac.ComputeHash(Encoding.UTF8.GetBytes(hash));
                hashLeft = Convert.ToBase64String(hmac.Hash);
                hashRight = string.Join(":", new string[] { username, ticks.ToString() });
            }
            return Convert.ToBase64String(Encoding.UTF8.GetBytes(string.Join(":", hashLeft, hashRight)));
        }
        private string GetHashedPassword(string password)
        {
            string key = string.Join(":", new string[] { password, _salt });
            using (HMAC hmac = HMACSHA256.Create(_alg))
            {
                // Hash the key.
                hmac.Key = Encoding.UTF8.GetBytes(_salt);
                hmac.ComputeHash(Encoding.UTF8.GetBytes(key));
                return Convert.ToBase64String(hmac.Hash);
            }
        }


         
        public static JwtPacket CreateJwtPacket(UserMaster user)//SigningCredentials
        {
            //var key = Encoding.ASCII.GetBytes(user.Email + DateTime.UtcNow.ToString());
            //var signingKey = new System.IdentityModel.Tokens.SymmetricSecurityKey(key);

            ////SigningCredentials signingCredentials = new SigningCredentials( new SymmetricSecurityKey(key), Microsoft.IdentityModel.Tokens.SecurityAlgorithms.HmacSha256Signature);

            //SigningCredentials signingCredentials = new SigningCredentials(signingKey, SecurityAlgorithms.HmacSha256Signature, SecurityAlgorithms.Sha256Digest);

            //var claims = new Claim[]
            //{
            //    new Claim(JwtRegisteredClaimNames.Sub, user.Id.ToString()),
            //    new Claim(ClaimTypes.Role, user.RoleName.ToUpper())
            //};


            //var jwt = new JwtSecurityToken(claims: claims, signingCredentials: signingCredentials);

            //var encodedJwt = new JwtSecurityTokenHandler().WriteToken(jwt);

            //return new JwtPacket()
            //{
            //    Token = encodedJwt,
            //    FirstName = user.FirstName,
            //    LastName = user.LastName,
            //    Email = user.RoleName,
            //    RoleId = user.RoleId,
            //    RoleName = user.RoleName
            //};

            return new JwtPacket()
            {
                Token = user.Session,
                SessionExpireTime = user.SessionExpireTime,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Email = user.Email,
                RoleId = user.RoleId,
                RoleName = user.RoleName
            };

        }
    }
}
