<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>
        <body>
        <h1>LIBRI</h1> 
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
            
                <form action="AggiungiLib.jsp" method="POST">
                     ISBN: <input type="text" id="ISBN" name="ISBN" placeholder="ISBN" required> 
                     Titolo: <input type="text" id="Titolo" name="Titolo" placeholder="Titolo" required><br>  
                     Autore: <input type="Autore" id="Autore" name="Autore" placeholder="Autore" required> 
                     Trama: <input type="text" id="Trama" name="Trama" placeholder="Trama" required>
                     Casa produtrice <input type="CasaProdutrice" id="CasaProdutrice" name="CasaProdutrice" placeholder="CasaProdutrice" required>
                     Prezzo <input type="number" id="Prezzo" name="Prezzo" placeholder="Prezzo" required>
                     Quantità <input type="number" id="Quantita" name="Quantita" placeholder="Quantita" required> <br>
                     Stato <input type="radio" id="Stato" name="Stato" value="nuovo" required>
                     <label for="nuovo"> nuovo </label>
                     <input type="radio" id="Stato" name="Stato" value="usato" required>
                     <label for="usato"> usato </label><br>


        <input type="submit" id="btn" name="btn" value="Aggiungi">
    </form>

    <a href="VisLibri.jsp">
        <input type="button" value="Indietro" /> <br>
    </a>
    </body>


        <%
        
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Database.accdb");
            String isbn=null;
            String tit=null;
            String autore = null;
            String trama = null;
            String casap=null;
            String prezzo=null;
            String quant=null;
            String stat=null;
            
           

            

                isbn = request.getParameter("ISBN");
                tit = request.getParameter("Titolo");
                autore = request.getParameter("Autore");
                trama= request.getParameter("Trama");
                casap= request.getParameter("CasaProdutrice");
                prezzo=request.getParameter("Prezzo");
                quant=request.getParameter("Quantita");
                stat=request.getParameter("Stato");
                if(isbn!=null && tit!=null && autore!=null && trama!=null && casap!=null && prezzo!=null && quant!=null && stat!=null)
                {
                    String query = "INSERT INTO Libri (ISBN,Titolo,Autore,Trama,CasaProdutrice,Prezzo,Quantita,Stato,Proprietario) values ('"+isbn+"', '"+tit+"', '"+autore+"', '"+trama+"','"+casap+"','"+prezzo+"','"+quant+"','"+stat+"','"+nome+"');";
                    Statement st = connection.createStatement(); 
                    st.executeUpdate(query);
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
      </body>
    </html>