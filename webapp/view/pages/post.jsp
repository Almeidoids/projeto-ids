<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language = "java" import = "java.sql.*" %>
<%@ include file = "../../api/util/connector.jspf"  %>

<%
        // Variaveis para acessar o banco de dados
        int id = Integer.parseInt(request.getParameter("id"));

        Connection connection = Connect();

        String sql = "SELECT * FROM posts WHERE id = " + id;
        
        PreparedStatement stm = connection.prepareStatement( sql ) ;
        ResultSet dados = stm.executeQuery();

        dados.next();

        String[] date = dados.getDate("tempo_postagem").toString().split("-");
%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Post</title>
        <link rel = "stylesheet" href = "../styles/post.css" />
    </head>

    <body>
    
        <main class = "blogSection">
        	<header>
        		<a href = "./blogs.jsp"><button class = "backBtn">< Voltar</button></a>
        		
        		<h1 class = "title"><%= dados.getString("titulo") %></h1>
	            <h3 class = "subtitle"><%= dados.getString("subtitulo") %></h3>
	            <h4 class = "date">Publicado em: <%= date[2] + "/" + date[1] + "/" + date[0] %></h4>
        	</header>
        	
        	<section>
				<p class = "txtBdy"><%= dados.getString("corpo") %></p>
        	</section>

        </main>

    </body>
</html>