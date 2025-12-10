<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language = "java" import = "java.sql.*" %>
<%@ include file = "../../api/util/connector.jspf"  %>

<%      
	Connection connection = Connect();
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blogs</title>
    <link rel = "stylesheet" href = "../styles/blogs.css" />

</head>
<body>
    <main class = "algnPosts">
    
    <% 
    
        String sql = "SELECT * FROM postS";
        PreparedStatement stm = connection.prepareStatement( sql ) ;
        ResultSet dados = stm.executeQuery();

        while (dados.next()) {
            String date = dados.getDate("tempo_postagem").toString();
            String[] arrDate = date.split("-");
    %>

        <article class = "card" >


            <p class = "date" ><%= arrDate[2] + "/" + arrDate[1] + "/" + arrDate[0] %></p>

            <section>
                <h1 class = "name"><%= dados.getString("titulo") %> </h1>
                <p class = "text"><%= dados.getString("subtitulo") %></p>
            </section>

            <footer class = 'algnActions'>
                <a href = <%= "./post.jsp?id=" + dados.getInt("id") %> >
                    <button class = "button" >
                        Veja mais
                    </button>
                </a>
            </footer>
        </article>

    <% 
        }
    %>


    </main>
</body>
</html>