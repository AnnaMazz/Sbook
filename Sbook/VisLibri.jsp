    <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        
<html>
    <head>
    </head>
    <body>
        <h1> TABELLA LIBRI </h1>
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
                String query= "SELECT * FROM Libri WHERE Proprietario!='"+nome+"';";
                Statement statement=connection.createStatement();
                ResultSet resultset=statement.executeQuery(query);
                String id=null;
                
                if(nome!=null){
                    out.println("<table style=\"border: 1px solid black;\">");
                    out.println("<tr>");
                    out.println("<th style=\"border: 1px solid black;\">ISBN</th>");
                    out.println("<th style=\"border: 1px solid black;\">Titolo</th>");
                    out.println("<th style=\"border: 1px solid black;\">Autore</th>");
                    out.println("<th style=\"border: 1px solid black;\">Trama</th>");
                    out.println("<th style=\"border: 1px solid black;\">Casa Produtrice</th>");
                    out.println("<th style=\"border: 1px solid black;\">Prezzo</th>");
                    out.println("<th style=\"border: 1px solid black;\">Quantit&agrave</th>");
                    out.println("<th style=\"border: 1px solid black;\">Stato</th>");
                    out.println("<th style=\"border: 1px solid black;\">Proprietario</th>");
                    out.println("<th style=\"border: 1px solid black;\"></th></tr>");
                    while(resultset.next()){
                        id=resultset.getString(1);
                        out.println("<tr><td style=\"border: 1px solid black;\">"+resultset.getString(1)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(2)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(3)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(4)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(5)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(6)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(7)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(8)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\">"+resultset.getString(9)+"</td>");
                        out.println("<td style=\"border: 1px solid black;\"><a href='Acquista.jsp?ISBN="+resultset.getString(1)+"'><input type=\"submit\" value=\"Acquista ora\"></a></td></tr>"); 
                                       
                        }
                        out.println("</table><br>");
                    if(id==null){
                        out.println("Nessun libro disponibile");
                    }
                }
                else{
                    out.println("<a href=\"index.html\"><input type=\"submit\" value=\"Non ti sei ancora loggato\" /> <br></a>");
                }
            }
            catch (Exception er) {
                System.out.println(er);
            }    
    %>
    <body>
    <a href="AggiungiLib.jsp">
            <input type="button" value="Aggiungi" /> 
    </a><br>
    <a href="VisLibriMio.jsp">
            <input type="button" value="VisualizzaMieiLibri" /> 
    </a><br>
    <a href="Logout.jsp">
            <input type="button" value="Logout" /> 
    </a><br>
    </body>
</html>