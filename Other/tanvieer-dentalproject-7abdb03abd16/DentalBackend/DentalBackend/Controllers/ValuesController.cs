using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DentalBackend.Controllers
{
    [Route("api/[controller]")]
    public class ValuesController : Controller
    {



        //[Authorize(Roles = "Administrator")]
        [Authorize(Roles = "Manager")]
        [HttpGet("manager")]
        public ActionResult GetManager()
        {
            return Ok("Sucess!");
        }

        [Authorize(Roles = "Administrator")]
        [HttpGet("admin")]
        public ActionResult GetAdmin()
        {
            return Ok("Sucess!");
        }

        [Authorize(Roles = "User")]
        [HttpGet("user")]
        public ActionResult GetUser()
        {
            return Ok("Sucess!");
        }



        [Authorize(Roles = "Administrator")]
        [Authorize(Roles = "User")]
        [Authorize(Roles = "Manager")]
        [HttpGet("all")]
        public ActionResult GetAll()
        {
            return Ok("Sucess!");
        }

        [HttpGet("get")]
        public ActionResult Get()
        {
            return Ok("Sucess!");
        }


        [HttpGet("me")]
        public ActionResult Gett()
        {
            return Ok("Sucess!");
        }
    }
}
