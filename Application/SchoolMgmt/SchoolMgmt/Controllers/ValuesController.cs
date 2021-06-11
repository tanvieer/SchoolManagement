using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SchoolMgmt.Model.ViewModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace SchoolMgmt.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ValuesController : ControllerBase
    {
        // GET: api/<ValuesController>
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<ValuesController>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<ValuesController>
        [HttpPost]
        public void Post(LoginViewModel model)
        {
        }

        // PUT api/<ValuesController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<ValuesController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }







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

         

        [HttpGet("me")]
        public ActionResult Gett()
        {
            return Ok("Sucess!");
        }

    }
}
