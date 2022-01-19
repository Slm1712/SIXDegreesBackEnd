using System.Data;
using System.Threading.Tasks;
using com.SIXDegrees.Shared.ModelDTO;

namespace com.SIXDegrees.Infrastructure.DataAccess.Interfaces
{
    public interface IUsuariosDAL
    {
        DataSet getUsuarios();
    }

}