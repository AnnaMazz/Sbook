<%@ page import="java.sql.Connection" %>
    <%@ page import="java.io.*" %>
        <%@ page import="java.sql.DriverManager" %>
            <%@ page import="java.sql.Statement" %>
                <%@ page import="java.sql.SQLException" %>
                    <%@ page import="java.sql.ResultSet" %>
                        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title> Login </title>
    </head>
    <body>
     <%

            try 
            {
                    Class.forName("net.ucanaccess.jdbc.UcanaccessDriver");
            } catch (ClassNotFoundException e) 
            {
                System.out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }
            try 
            {
                Connection connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Database.accdb");
                String username=request.getParameter("username");
                String password=request.getParameter("password");
                String query= "SELECT Username FROM Utenti WHERE Username= '" + username + "' AND Password= '"+ password +"';";
                Statement statement=connection.createStatement();
                ResultSet resultset=statement.executeQuery(query);
                HttpSession s = request.getSession();
                String nome=null;
                while(resultset.next())
                {
                    nome=resultset.getString(1);
                   
                }
                if(nome==null)
                {
                    out.println("Utente o Password sbagliati<br>");
                    out.println("<a href=\"index.html\">Torna in indietro</a> <br>");
                    out.println("<a href=\"SignIn.jsp\">Registati</a> <br>");
                }
                else
                {
                     s.setAttribute("username", nome);
                     response.sendRedirect("VisLibri.jsp");
                }
            }
            catch (Exception e)
            {
                System.out.println("Errore: Impossibile caricare il Driver Ucanaccess");
         }

            %>
        </body>
        
    
</html>