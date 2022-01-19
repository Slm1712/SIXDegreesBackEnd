using System;
using System.Data;
using System.Data.SqlClient;

namespace com.SIXDegrees.Shared.SqlData
{
    public class SqlObjectData
    {
        public bool BulkInsertDataTable(string tableName, DataTable table, string connectionString)
        {

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();


                try
                {
                    SqlBulkCopy bulkCopy =
                        new SqlBulkCopy
                        (
                       connection,
                         SqlBulkCopyOptions.TableLock |
                          SqlBulkCopyOptions.KeepNulls |
                        SqlBulkCopyOptions.Default,

                        null

                        );
                    bulkCopy.BulkCopyTimeout = 0;
                    bulkCopy.DestinationTableName = tableName;



                    bulkCopy.WriteToServer(table);
                   
                    return true;

                }

#pragma warning disable CS0168 // The variable 'ex' is declared but never used
                catch (Exception ex)
#pragma warning restore CS0168 // The variable 'ex' is declared but never used

                {
                    //retornar mensaje o capturar en el log de errores la excepcion
                    return false;
                }
                finally
                {
                    connection.Close();
                }


            }

        }



    }
}