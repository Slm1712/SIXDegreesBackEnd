using System;
using System.IO;

namespace com.SIXDegrees.Shared.LogEvent
{
    public class LogEvent
    {
        private string m_exePath = string.Empty;

        public void LogWrite(string logMessage)
        {
            string path = @"C:\EventLogF2X\Utils";
            if (!System.IO.Directory.Exists(path))
                System.IO.Directory.CreateDirectory(path);



            try
            {
                using (StreamWriter w = File.AppendText(path + "\\" + "log_" + DateTime.Now.ToShortDateString().Replace('/', '_') + ".txt"))
                {
                    Log(logMessage, w);
                }
            }
#pragma warning disable CS0168 // The variable 'ex' is declared but never used
            catch (Exception ex)
#pragma warning restore CS0168 // The variable 'ex' is declared but never used
            {
            }
        }

        public void Log(string logMessage, TextWriter txtWriter)
        {
            try
            {
                txtWriter.Write("\r\nLog Entry : ");
                txtWriter.WriteLine("{0} {1}", DateTime.Now.ToLongTimeString(),
                    DateTime.Now.ToLongDateString());
                txtWriter.WriteLine("{0}", logMessage);
                txtWriter.WriteLine("--------------------------------------------------------------------------------");
            }
#pragma warning disable CS0168 // The variable 'ex' is declared but never used
            catch (Exception ex)
#pragma warning restore CS0168 // The variable 'ex' is declared but never used
            {
            }
        }
    }
}
