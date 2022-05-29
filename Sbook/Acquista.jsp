<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
    <head>
    <link rel="stylesheet" type="text/css" href="stile.css">
    </head>
        <body>
        <h1>LIBRI</h1> 
        <%
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
            String data = null;
            String query = null;
            String query1 = null;
            String query2 = null;
            String query3 = null;
            int q=0;

            Statement st;
            ResultSet rs;
        Connection connection=null;
        try{
            Class.forName(DRIVER);
        }
        catch (ClassNotFoundException e) {
            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }
        try
        {
           
            
            HttpSession s = request.getSession();
             String nome = (String) s.getAttribute("username");
             String is= (String) request.getParameter("ISBN");
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Database.accdb");
            if(nome!=null)
            {
                boolean contr=true;
                query3="SELECT ISBN FROM ACQUISTI WHERE ISBN='"+is+"' AND Utente='"+nome+"';";
                st=connection.createStatement(); 
                rs=st.executeQuery(query3);
                while(rs.next()){
                       contr=false;
                }
            
                if(contr==true)
                {
                    query1="SELECT Quantita FROM Libri WHERE ISBN='"+is+"';";
                    st=connection.createStatement(); 
                    rs=st.executeQuery(query1);
                    while(rs.next()){
                       q=Integer.parseInt(rs.getString(1));

                    }
            
                    q--;
                    query2 = "UPDATE Libri SET Quantita='"+q+"' WHERE ISBN = '"+is+"';";
                    st.executeUpdate(query2);
                    DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    long miliseconds = System.currentTimeMillis();
		            Date d = new Date(miliseconds);        
		            data = dateFormat.format(d);

                    query = "INSERT INTO Acquisti (ISBN,Utente,DataAcquisto) values ('"+is+"', '"+nome+"', #"+data+"#);";
                    st.executeUpdate(query);
                   out.println("Il tuo acquisto &egrave avvenuto corretemente");
                }
                else
                {
                    out.println("Hai gi&agrave acquistato questo libro");
                }
            }
            else
            {
                out.println("<a href=\"index.html\"><input type=\"submit\" value=\"Non ti sei ancora loggato\" /> <br></a>");
            }
           
        }
        catch(Exception e){
            out.println(e);
        }
        finally{
            if(connection != null){
                try{
                    connection.close();
                }
                catch(Exception e)
                {
                    out.println("Errore nella chiusura della connessione");}

                }
        }
        %>
     
    <a href="VisLibri.jsp">Indietro<br></a>
     <a href="VisAcq.jsp">Visualizza acquisti"<br></a>
      </body>
    </html>