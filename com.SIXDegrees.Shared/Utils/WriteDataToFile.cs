using System;
using System.Data;
using System.IO;
using System.Text;
using Microsoft.Extensions.Configuration;


namespace com.SIXDegrees.Shared.Utils
{
    public static class WriteDataToFile
    {

        public static string DataTableData(DataTable data)
        {
            StringBuilder sb = new StringBuilder();
            string nombreArchivo = "";

            string writeLog = "";
            string stringData = "";

            try
            {
                var configurationBuilder = new ConfigurationBuilder();
                var pathJson = Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json");
                configurationBuilder.AddJsonFile(pathJson, false);

                var root = configurationBuilder.Build();
                var path = root.GetSection("pathArchivoPLanoEmpaque").Value.ToString();


                foreach (DataRow dr in data.Rows)
                {
                    nombreArchivo = dr["NombreArchivo"].ToString();

                    if (!System.IO.File.Exists(path + "\\" + nombreArchivo))
                    {
                        stringData = dr["Inicio"].ToString() + dr["Docto"].ToString() + dr["Movto"].ToString() + dr["Final"].ToString();

                    }


                }

                if (!System.IO.File.Exists(path + "\\" + nombreArchivo))
                {
                    if (!System.IO.Directory.Exists(path))
                        System.IO.Directory.CreateDirectory(path);

                    using (StreamWriter writer = File.AppendText(path + "\\" + nombreArchivo))
                    {

                        writeLog = WriteToFile(stringData, writer);
                    }


                    return writeLog;
                }
                else return "El archivo " + nombreArchivo + " ya existe en la ubicación " + path;

            }
            catch (Exception ex)
            {

                return "No se creo correctamente el archivo plano, excepción técnica: " + ex.Message;

            }


        }



        private static string WriteToFile(string stringData, TextWriter txtWriter)
        {
            try
            {

                txtWriter.WriteLine(stringData);
                return "";

            }

            catch (Exception ex)
            {
                return "No se creo correctamente el archivo plano, excepción técnica: " + ex.Message;
            }


        }


        //private static string WriteToFile(string nombreArchivo, string path, string text)
        //{
        //    try
        //    {

        //        if (!System.IO.Directory.Exists(path))
        //            System.IO.Directory.CreateDirectory(path);

        //        using (StreamWriter writer = File.AppendText(path + "\\" + nombreArchivo))
        //        {

        //            writer.WriteLine(text);                
        //            writer.Close();
        //        }

        //        return "";
        //    }
        //    catch (Exception ex)
        //    {

        //        return "No se creo correctamente el archivo plano, excepción técnica: " + ex.Message;

        //    }

        //}
    }



}
