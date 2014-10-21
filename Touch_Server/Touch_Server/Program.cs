using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace Touch_Server
{
    class Program
    {
        static int Main(string[] args)
        {
            CorruptedSmileStudio.INI.INIContent config;
            try
            {
                config = CorruptedSmileStudio.INI.INIFile.Read(System.Environment.GetFolderPath(System.Environment.SpecialFolder.MyDocuments) + "\\TouchToPC\\config.ini");
            }
            catch
            {
                config = new CorruptedSmileStudio.INI.INIContent();
                System.IO.Directory.CreateDirectory(System.Environment.GetFolderPath(System.Environment.SpecialFolder.MyDocuments) + "\\TouchToPC\\");
                config.Change("Height", 768.0f, "Layout");
                config.Change("Width", 1280.0f, "Layout");
                config.Change("Port", 15000, "Connection");
                CorruptedSmileStudio.INI.INIFile.Write(System.Environment.GetFolderPath(System.Environment.SpecialFolder.MyDocuments) + "\\TouchToPC\\config.ini", config);
            }

            AsynchronousSocketListener socketListener = new AsynchronousSocketListener(config);
            socketListener.StartListening();

            return 0;
        }
    }
}