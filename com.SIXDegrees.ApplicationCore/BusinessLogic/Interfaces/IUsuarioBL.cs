using System.Data;
using System.Threading.Tasks;
using com.SIXDegrees.Infrastructure.Models;
using Newtonsoft.Json.Linq;

namespace com.SIXDegrees.ApplicationCore.BusinessLogic.Interfaces
{
    public interface IUsuarioBL
    {
        //Task<Usuarios> GetUsuarioAsync(long UsuarioId);
        //Task<Usuarios> GetUsuarioLoginAsync(JObject usuarioJson);
        //DataSet getPermisosByUsuarioId(long usuarioId);
        DataSet getUsuarios();
    }
}