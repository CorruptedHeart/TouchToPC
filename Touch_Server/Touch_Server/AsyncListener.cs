using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using WindowsInput;

namespace Touch_Server
{
    public class AsynchronousSocketListener
    {
        /// <summary>
        /// Thread signal.
        /// </summary>
        public ManualResetEvent allDone = new ManualResetEvent(false);

        CorruptedSmileStudio.INI.INIContent config;

        float height, width;
        bool leftDown = false;
        bool rightDown = false;
        bool middleDown = false;
        Socket listener;
        List<Access> access = new List<Access>();
        EndPoint epSender;

        public AsynchronousSocketListener(CorruptedSmileStudio.INI.INIContent config)
        {
            this.config = config;

            height = System.Windows.Forms.SystemInformation.PrimaryMonitorSize.Height / config.GetFloat("Height", "Layout", 768.0f);
            width = System.Windows.Forms.SystemInformation.PrimaryMonitorSize.Width / config.GetFloat("Width", "Layout", 1280.0f);
        }

        public void StartListening()
        {
            IPEndPoint localEndPoint = new IPEndPoint(IPAddress.Any, config.GetInt("Port", "Connection", 15000));

            // Create a UDP/IP socket.
            listener = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
            // Bind the socket to the local endpoint and listen for incoming connections.
            epSender = (EndPoint)new IPEndPoint(IPAddress.Any, 0);
            IPHostEntry host;
            host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (IPAddress ip in host.AddressList)
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    Console.WriteLine("IP Address: " + ip.ToString());
                }
            }
            try
            {
                listener.Bind(localEndPoint);

                while (true)
                {
                    byte[] bytes = new Byte[1024];
                    // Set the event to nonsignaled state.
                    allDone.Reset();

                    if (config.GetBool("print", "Debug", true))
                    {
                        // Start an asynchronous socket to listen for connections.
                        Console.WriteLine("Waiting for a connection...");
                    }
                    listener.BeginReceiveFrom(bytes, 0, bytes.Length, SocketFlags.None, ref epSender,
                        new AsyncCallback(ReadCallback), bytes);

                    // Wait until a connection is made before continuing.
                    allDone.WaitOne();
                }

            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }

            Console.WriteLine("\nPress ENTER to continue...");
            Console.Read();
        }

        public void ReadCallback(IAsyncResult ar)
        {
            // Read data from the client socket.
            int bytesRead = listener.EndReceiveFrom(ar, ref epSender);

            if (bytesRead > 0)
            {
                byte[] aux = new byte[1024];
                aux = (byte[])ar.AsyncState;
                Access acc = new Access();
                bool found = false;
                for (int i = 0; i < access.Count; i++)
                {
                    if (access[i].epSender.ToString() == epSender.ToString())
                    {
                        found = true;
                        acc = access[i];
                        break;
                    }
                }
                if (!found)
                {
                    acc.epSender = epSender;
                    access.Add(acc);
                }
                Receive(ASCIIEncoding.UTF8.GetString(aux, 0, aux.Length), acc);
            }
            allDone.Set();
        }

        private void Receive(string text, Access acc)
        {
            text = text.TrimEnd('\0');
            if (config.GetBool("print", "Debug", true))
            {
                Console.WriteLine(text);
            }
            if (acc.accessAllowed || config.GetString("Password", "Connection", "") == "")
            {
                // Move Mouse pointer
                if (text.StartsWith("X:"))
                {
                    int x = int.Parse(text.Substring(2, text.IndexOf("Y") - 2));
                    int y = int.Parse(text.Substring(text.IndexOf("Y:") + 2));
                    MouseOperations.SetCursorPosition(new MouseOperations.MousePoint((int)(x * width), (int)(y * height)));
                }
                // Key entry
                else if (text.StartsWith("K:"))
                {
                    // Media keys
                    if (text.Contains("MEDIA"))
                    {
                        if (text.EndsWith("NT"))
                            InputSimulator.SimulateKeyPress(VirtualKeyCode.MEDIA_NEXT_TRACK);
                        else if (text.EndsWith("PT"))
                            InputSimulator.SimulateKeyPress(VirtualKeyCode.MEDIA_PREV_TRACK);
                        else if (text.EndsWith("PLAY"))
                            InputSimulator.SimulateKeyPress(VirtualKeyCode.MEDIA_PLAY_PAUSE);
                        else if (text.EndsWith("VD"))
                            InputSimulator.SimulateKeyPress(VirtualKeyCode.VOLUME_DOWN);
                        else if (text.EndsWith("VU"))
                            InputSimulator.SimulateKeyPress(VirtualKeyCode.VOLUME_UP);
                        else if (text.EndsWith("VM"))
                            InputSimulator.SimulateKeyPress(VirtualKeyCode.VOLUME_MUTE);
                        else if (text.EndsWith("STOP"))
                            InputSimulator.SimulateKeyPress(VirtualKeyCode.MEDIA_STOP);
                    }
                    // Key entry
                    else
                    {
                        if (text.Length > 3)
                        {
                            if (text.EndsWith("PAGEUP"))
                            {
                                InputSimulator.SimulateKeyPress(VirtualKeyCode.PRIOR);
                            }
                            else if (text.EndsWith("PAGEDOWN"))
                            {
                                InputSimulator.SimulateKeyPress(VirtualKeyCode.NEXT);
                            }
                            else if (text.EndsWith("ARROW-UP"))
                            {
                                InputSimulator.SimulateKeyPress(VirtualKeyCode.UP);
                            }
                            else if (text.EndsWith("ARROW-DOWN"))
                            {
                                InputSimulator.SimulateKeyPress(VirtualKeyCode.DOWN);
                            }
                            else if (text.EndsWith("ARROW-LEFT"))
                            {
                                InputSimulator.SimulateKeyPress(VirtualKeyCode.LEFT);
                            }
                            else if (text.EndsWith("ARROW-RIGHT"))
                            {
                                InputSimulator.SimulateKeyPress(VirtualKeyCode.RIGHT);
                            }
                            else if (text.EndsWith("ENTER"))
                            {
                                InputSimulator.SimulateKeyPress(VirtualKeyCode.RETURN);
                            }
                            else if (text.EndsWith("BACKSPACE"))
                            {
                                InputSimulator.SimulateKeyPress(VirtualKeyCode.BACK);
                            }
                            else if (text.EndsWith("DELETE"))
                            {
                                InputSimulator.SimulateKeyPress(VirtualKeyCode.DELETE);
                            }
                            else
                            {
                                InputSimulator.SimulateTextEntry(text.Substring(2));
                            }
                        }
                        else if (text.Length == 3)
                        {
                            int valueOfA = (int)'A';
                            int valueOfa = (int)'a';
                            int valueOfz = (int)'z';
                            char key = text.Substring(2, 1)[0];
                            int value = (int)key;

                            if (value >= valueOfA && value <= valueOfz)
                            {
                                bool cap = false;
                                if (value >= valueOfa)
                                {
                                    Console.WriteLine(value);
                                    value = value - (valueOfa - valueOfA);
                                    Console.WriteLine(value);
                                    Console.WriteLine((valueOfa - valueOfA));
                                }
                                else
                                {
                                    cap = true;
                                }
                                if (cap)
                                    InputSimulator.SimulateKeyDown(VirtualKeyCode.RSHIFT);
                                InputSimulator.SimulateKeyPress((VirtualKeyCode)value);
                                if (cap)
                                    InputSimulator.SimulateKeyUp(VirtualKeyCode.RSHIFT);
                            }
                            else
                            {
                                //InputSimulator.SimulateKeyPress((VirtualKeyCode)value);
                                InputSimulator.SimulateTextEntry(text.Substring(2));
                            }
                        }
                    }
                }
                else if (text.StartsWith("S:"))
                {
                    if (config.GetBool("print", "Debug", true))
                    {
                        Console.WriteLine("Attempting to start: " + text.Substring(2));
                    }
                    try
                    {
                        System.Diagnostics.ProcessStartInfo app;
                        if (text.Contains(" "))
                        {
                            string[] parts = text.Split(' ');
                            string arguments = "";
                            for (int i = 1; i < parts.Length; i++)
                            {
                                arguments += parts[i];
                            }
                            app = new System.Diagnostics.ProcessStartInfo(parts[0].Substring(2), arguments);

                        }
                        else
                        {
                            app = new System.Diagnostics.ProcessStartInfo(text.Substring(2));
                        }
                        System.Diagnostics.Process.Start(app);
                    }
                    catch (Exception ex)
                    {
                        if (config.GetBool("print", "Debug", true))
                        {
                            Console.WriteLine("Unable to find or start: {0}\nDue to: {1}", text.Substring(2), ex);
                        }
                    }
                }
                else if (text.StartsWith("I"))
                {
                    System.Drawing.Bitmap bmpScreenshot = new System.Drawing.Bitmap(System.Windows.Forms.Screen.PrimaryScreen.Bounds.Width, System.Windows.Forms.Screen.PrimaryScreen.Bounds.Height, System.Drawing.Imaging.PixelFormat.Format32bppArgb);
                    System.Drawing.Graphics gfxScreenshot = System.Drawing.Graphics.FromImage(bmpScreenshot);
                    gfxScreenshot.CopyFromScreen(System.Windows.Forms.Screen.PrimaryScreen.Bounds.X, System.Windows.Forms.Screen.PrimaryScreen.Bounds.Y, 0, 0, System.Windows.Forms.Screen.PrimaryScreen.Bounds.Size, System.Drawing.CopyPixelOperation.SourceCopy);
                    System.IO.MemoryStream ms = new System.IO.MemoryStream();
                    bmpScreenshot = (System.Drawing.Bitmap)bmpScreenshot.GetThumbnailImage(config.GetInt("Width", "Layout", 1280), config.GetInt("Height", "Layout", 768), null, IntPtr.Zero);
                    bmpScreenshot.Save(ms, System.Drawing.Imaging.ImageFormat.Jpeg);
                    bmpScreenshot.Dispose();
                    Send(ms.ToArray(), acc.epSender);
                    /*                    Send(new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp), new byte[] { (byte)'a', (byte)'b', (byte)'c' }, acc.epSender);*/
                }
                else
                {
                    // Left Click
                    if (text.StartsWith("0"))
                    {
                        if (text.EndsWith("1"))
                        {
                            if (!leftDown)
                                MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.LeftDown);
                            else
                                MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.LeftUp);
                            leftDown = !leftDown;
                        }
                        else
                        {
                            leftDown = false;
                            MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.LeftDown);
                            MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.LeftUp);
                        }
                    }
                    // Right Click
                    if (text.StartsWith("1"))
                    {
                        if (text.EndsWith("1"))
                        {
                            if (!rightDown)
                                MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.RightDown);
                            else
                                MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.RightUp);
                            rightDown = !rightDown;
                        }
                        else
                        {
                            rightDown = false;
                            MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.RightDown);
                            MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.RightUp);
                        }
                    }
                    // Middle Click
                    if (text.StartsWith("2"))
                    {
                        if (text.EndsWith("1"))
                        {
                            if (!middleDown)
                                MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.MiddleDown);
                            else
                                MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.MiddleUp);
                            middleDown = !middleDown;
                        }
                        else
                        {
                            middleDown = false;
                            MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.MiddleDown);
                            MouseOperations.MouseEvent(MouseOperations.MouseEventFlags.MiddleUp);
                        }
                    }
                }
            }
            else
            {
                // Password checking for access.
                if (text.StartsWith("P:"))
                {
                    string password = text.Substring(2);
                    if (password == config.GetString("Password", "Connection", ""))
                    {
                        Console.WriteLine("Access Allowed");
                        acc.accessAllowed = true;
                    }
                    else
                    {
                        Console.WriteLine("Access Denied");
                        acc.accessAllowed = false;
                    }
                }
            }
        }

        private void SendCallback(IAsyncResult ar)
        {
            Socket handler = new Socket(SocketType.Dgram, ProtocolType.Udp);
            try
            {
                // Retrieve the socket from the state object.
                handler = (Socket)ar.AsyncState;

                // Complete sending the data to the remote device.
                int bytesSent = handler.EndSend(ar);
                Console.WriteLine("Sent {0} bytes to client.", bytesSent);

            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
            finally
            {
                handler.Shutdown(SocketShutdown.Both);
                handler.Close();
                allDone.Set();
            }
        }

        private void Send(byte[] data, EndPoint receiver)
        {
            Socket handler = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            ((IPEndPoint)receiver).Port = 45454;
            handler.Connect(receiver);

            Console.WriteLine("Sent: " + SendData(handler, data));

            handler.Shutdown(SocketShutdown.Both);
            handler.Close();
        }

        private int SendData(Socket s, byte[] data)
        {
            int total = 0;
            int size = data.Length;
            int dataLeft = size;
            int sent;

            byte[] dataSize = new byte[4];
            dataSize = BitConverter.GetBytes(size);
            sent = s.Send(dataSize);
            while (total < size)
            {
                sent = s.Send(data, total, dataLeft, SocketFlags.None);
                total += sent;
                dataLeft -= sent;
            }
            return total;
        }
    }
}