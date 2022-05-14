<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
        <body>
        <h1>MODIFICA</h1> 
        <%
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
      
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
            if(nome!=null)
            {

        %>
            
                <form action="Modifica.jsp" method="POST">
                     Titolo: <input type="text" id="Titolo" name="Titolo" placeholder="Titolo" required><br>  
                     Autore: <input type="Autore" id="Autore" name="Autore" placeholder="Autore" required> 
                     Trama: <input type="text" id="Trama" name="Trama" placeholder="Trama" required>
                     Casa produtrice <input type="CasaProdutrice" id="CasaProdutrice" name="CasaProdutrice" placeholder="CasaProdutrice" required>
                     Prezzo <input type="number" id="Prezzo" name="Prezzo" placeholder="Prezzo" required>
                     Quantit&agrave <input type="number" id="Quantita" name="Quantita" placeholder="Quantita" required> <br>
                     Stato <input type="radio" id="Stato" name="Stato" value="nuovo" required>
                     <label for="nuovo"> nuovo </label>
                     <input type="radio" id="Stato" name="Stato" value="usato" required>
                     <label for="usato"> usato </label><br>


        <input type="submit" id="btn" name="btn" value="Modifica">
    </form>

    <a href="VisMIoLibri.jsp">
        <input type="button" value="Indietro" /> <br>
    </a>
    </body>


        <%
        
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Database.accdb");
            String isbn= (String) request.getParameter("ISBN");
            String tit=null;
            String aut= null;
            String tra = null;
            String csPro=null;
            String pre=null;
            String q=null;
            String sta=null;
            ResultSet r=null;

            tit = request.getParameter("Titolo");
            aut = request.getParameter("Autore");
            tra= request.getParameter("Trama");
            csPro= request.getParameter("CasaProdutrice");
            pre=request.getParameter("Prezzo");
            q=request.getParameter("Quantita");
            sta=request.getParameter("Stato");
                if(isbn!=null && tit!=null && aut!=null && tra!=null && csPro!=null && pre!=null && q!=null && sta!=null)
                {
                    String queryModifica = "UPDATE Libri SET Titolo = ISBN '"+isbn+"', Titolo = '"+tit+"' , Autore = '"+aut+"' , Trama = '"+tra+"',CasaProdutrice = '"+csPro+"', Prezzo = '"+pre+"', Quantita = '"+q+"', Stato= '"+sta+"';";
                    String query = "SELECT * FROM Libri WHERE Proprietario = '"+nome+"';";
                    Statement st = connection.createStatement();
                    r = st.executeQuery(query);
  
            st.executeUpdate(queryModifica);
            response.sendRedirect("VisLibriMio.jsp");
                }
            }
            else
            {
                out.println("<a href=\"index.html\"><input type=\"submit\" value=\"Per aggiungere libri devi essere logato\" /> <br></a>");
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
    </html>