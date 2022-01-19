using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using com.SIXDegrees.ApplicationCore.BusinessLogic.Interfaces;
using com.SIXDegrees.Infrastructure.DataAccess.Interfaces;
using com.SIXDegrees.Infrastructure.Models;

namespace com.SIXDegrees.ApplicationCore.BusinessLogic
{
    public class UsuarioBL : IUsuarioBL
    {
        private readonly IUsuariosDAL _usuarioDAL;

        public UsuarioBL(IUsuariosDAL usuarioDAL)
        {
            this._usuarioDAL = usuarioDAL;
        }

        public DataSet getUsuarios()
        {
            return this._usuarioDAL.getUsuarios();
        }

    }
}
