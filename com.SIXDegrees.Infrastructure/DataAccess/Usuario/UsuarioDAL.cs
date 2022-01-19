
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using com.SIXDegrees.Infrastructure.DataAccess.Interfaces;
using com.SIXDegrees.Shared.LogEvent;
using com.SIXDegrees.Infrastructure.Models;
using Microsoft.EntityFrameworkCore;

namespace com.SIXDegrees.Infrastructure.DataAccess
{
    public class UsuariosDAL : IUsuariosDAL
    {
        public SIXDegress_bdContext dbcontext;

        public UsuariosDAL()
        {
            dbcontext = new SIXDegress_bdContext();
        }

        public DataSet getUsuarios()
        {
            var dataSet = new DataSet();
            using (var connection = new SqlConnection(dbcontext.Database.GetDbConnection().ConnectionString))
            {
                connection.Open();
                try
                {

                    using (var command = new SqlCommand("[dbo].[get_Usuarios]", connection))
                    {
                        command.CommandType = System.Data.CommandType.StoredProcedure;
                        command.CommandTimeout = 0;

                        var adapter = new SqlDataAdapter(command);

                        adapter.Fill(dataSet);

                    }

                    return dataSet;
                }
                catch (System.Exception ex)
                {
                    LogEvent log = new LogEvent();
                    log.LogWrite(ex.Message);

                    return null;
                }

                finally
                {
                    connection.Close();
                }
            }
        }

    }
}
