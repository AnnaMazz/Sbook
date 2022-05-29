    <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        
<html>
    <head>
    <link rel="stylesheet" type="text/css" href="stile.css">
    </head>
    <body>
        <h1> TABELLA ACQUISTI </h1>
     </body>
        
        <%
            try {
                Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            } catch (ClassNotFoundException e) {
                System.out.println("Errore: Impossibile caricare il Driver Ucanaccess1");
            }
            try {
                Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Database.accdb");
                HttpSession s = request.getSession();
                String nome = (String) s.getAttribute("username");
                String query= "SELECT * FROM Acquisti WHERE Utente='"+nome+"';";
                Statement statement=connection.createStatement();
                ResultSet resultset=statement.executeQuery(query);
                String id=null;
                
                if(nome!=null){
                    out.println("<table style=\"border: 1px solid black;\">");
                    out.println("<tr>");
                    out.println("<th style=\"border: 1px solid black;\">ISBN</th>");
                    out.println("<th style=\"border: 1px solid black;\">Utente</th>");
                    out.println("<th style=\"border: 1px solid black;\">DataAcquisto</th></tr>");
                    //out.println("<th style=\"border: 1px solid black;\"></th></tr>");
                    while(resultset.next()){
                        id=resultset.getString(1);
                        out.println("<tr><td style=\"border: 1px solid black;\">"+resultset.getString(1)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(2)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(3).substring(0,10)+"</td></tr>");
                        //out.println("<td style=\"border: 1px solid black;\"><a href='Acquista.jsp?ISBN="+resultset.getString(1)+"'><input type=\"submit\" value=\"Acquista ora\"></a></td></tr>"); 
                                       
                        }
                        out.println("</table><br>");
                    if(id==null){
                        out.println("Nessun libro disponibile");
                    }
                }
                else{
                    out.println("<a href=\"index.html\">Non ti sei ancora logato:logati <br></a>");
                }
            }
            catch (Exception er) {
                System.out.println(er);
            }    
    %>
    <body>
    <a href="VisLibri.jsp">Indietro<br></a>
    <a href="Logout.jsp">Logout</a><br>
    </body>
</html>