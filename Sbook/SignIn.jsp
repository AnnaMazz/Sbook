<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
    <head>
    <link rel="stylesheet" type="text/css" href="stile.css">
    </head>
        <body>
            <h1>Sign-up Utenti</h1>
                <form action="SignIn.jsp" method="POST">
                     Nome: <input type="text" id="nome" name="nome" placeholder="nome" required> 
                     Cognome: <input type="text" id="cognome" name="cognome" placeholder="cognome" required>
                     Username: <input type="text" id="username" name="username" placeholder="username" required> 
                     Password: <input type="password" id="password" name="password" placeholder="password" required>

        <input type="submit" id="btn" name="btn" value="Sign-up">
    </form>

    <a href="index.html"> Indietro <br></a>
</body>


        <%
        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
        
        String user=null;
        String pass=null;
        String nome = null;
        String cognome = null;
                
        Connection connection=null;
        try{
            Class.forName(DRIVER);
        }
        catch (ClassNotFoundException e) {
            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }
        try{
            
            nome = request.getParameter("nome");
            cognome = request.getParameter("cognome");
            user = request.getParameter("username");
            pass= request.getParameter("password");
            
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Database.accdb");
            if(nome!=null && cognome!=null && user!=null && pass!=null)
            {
                String verifica = "SELECT Username from Utenti WHERE Username = '"+user+"';";
                Statement st = connection.createStatement();          
                ResultSet result = st.executeQuery(verifica);
            
                if(result.next()){
                    out.println("<p>Questo account è già esistente</p>");
                }else{
                    String query = "INSERT INTO Utenti (Username,Password,Nome,Cognome) values ('"+user+"', '"+pass+"', '"+nome+"', '"+cognome+"');";
                    st.executeUpdate(query);
                    response.sendRedirect("index.html");
                }
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
                catch(Exception e){out.println("Errore nella chiusura della connessione");}
            }
        }
        %>
        <a href="index.html"> Hai un accont,logati <br></a>
      </body>
    </html>