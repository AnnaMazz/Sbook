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
        <form action="Login" method="post">
            <input type="text" name="username" placeholder="Username"> <br>
            <input type="text" name="password" placeholder="Password"> <br>
            <input type="submit" value="accedi">
        </form>
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
            String query= "SELECT Nome FROM Utenti WHERE Username= '" + username + "' AND Password= '"+ password +"'";
            Statement statement=connection.createStatement();
            ResultSet resultset=statement.executeQuery(query);
            String nome=null;
            while(resultset.next())
            {
                nome=resultset.getString(1);
                   
            }
            if(nome==null)
            {
                 response.getOutputStream().println("Utente o Password sbagliati");
            }
            else
            {
                 response.getOutputStream().println("Benvenuto "+nome);
            }
        }
        catch (Exception e)
         {
            System.out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }
        %>
    </body>
</html>