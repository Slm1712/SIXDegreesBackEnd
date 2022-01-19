using System.Data;
using System.Threading.Tasks;
using com.SIXDegrees.ApplicationCore.BusinessLogic.Interfaces;
using com.SIXDegrees.ApplicationCore.BusinessLogic;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;

namespace com.SIXDegrees.WebAPI.Controllers.Usuarios
{   
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        private readonly IUsuarioBL _UsuarioBL;

        public UsuarioController(IUsuarioBL UsuarioBL)
        {
            this._UsuarioBL = UsuarioBL;
        }
       
        // GET: api/getPermisosByUsuarioId
        [Route("api/GetUsuarios")]
        [HttpGet]
        public JsonResult getUsuarios()
        {
            var result = this._UsuarioBL.getUsuarios();
            if (result == null)
            {
                result = new DataSet();
                DataTable dt = new DataTable("table");
                dt.Columns.Add(new DataColumn("resultado", typeof(string)));
                DataRow dr = dt.NewRow();
                dr["resultado"] = "Error al consumir el servicio, revise el log de eventos en la carpeta (C:\\EventLogTecnoCEDI\\Utils\\)";
                dt.Rows.Add(dr);
                result.Tables.Add(dt);
            }
            JsonResult json = new JsonResult(result);
            if (json.Value == null)
            {
                json.StatusCode = 500;
                json.Value = "Error al consumir el servicio, revise el log de eventos en la carpeta (C:\\EventLogTecnoCEDI\\Utils\\)";
            }
            else
                json.StatusCode = 200;

            return json;
        }

    }
}
