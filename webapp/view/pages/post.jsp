<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language = "java" import = "java.sql.*" %>
<%@ include file = "../../api/util/connector.jspf"  %>

<%
        // Variaveis para acessar o banco de dados
        int id = Integer.parseInt(request.getParameter("id"));

        Connection connection = Connect();

        String sql = "SELECT * FROM postS WHERE id = " + id;
        
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
				<p class = "txtBdy">

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ultrices, lacus non semper aliquam, velit enim luctus leo, eu aliquet libero dolor quis ipsum. Pellentesque est diam, venenatis vitae massa vel, condimentum mollis augue. Cras a viverra nulla, eu fringilla libero. Fusce varius urna sed consectetur eleifend. Cras venenatis et erat id lobortis. Duis aliquam leo ante, in hendrerit justo lacinia at. Nullam sed varius ex. Aliquam dignissim, lorem et aliquam venenatis, risus ante congue enim, vitae aliquet est magna vel est. Donec lacinia vehicula tellus sit amet fringilla. Fusce scelerisque mi sit amet ultricies tempor. Mauris sed ante ut ex porttitor eleifend. Quisque molestie enim id tincidunt mattis. Cras euismod nec magna quis fringilla. Maecenas interdum erat vel augue pulvinar iaculis. Donec fermentum, nibh a ornare scelerisque, risus ante mattis lectus, ut porta risus lacus id diam. Nunc at rutrum felis.

Morbi ornare eu nunc eu placerat. Cras vitae massa vel justo vestibulum gravida. Sed feugiat neque tortor, in gravida lorem pharetra sed. Quisque sed ex venenatis, venenatis nisl vel, mattis massa. Quisque id ex sed urna consequat placerat. Morbi viverra, nisl eu mollis dictum, mi arcu semper eros, nec bibendum nisi augue id nulla. Ut vulputate suscipit condimentum. Nullam quis facilisis arcu. Vivamus iaculis fermentum eros, vel pellentesque ante. Nullam in laoreet arcu. Maecenas dapibus aliquet imperdiet. Praesent et varius ipsum, a faucibus ipsum. Proin iaculis sem sed purus finibus commodo. Vivamus rhoncus sit amet urna quis venenatis.

Vivamus lectus mi, euismod non lorem et, gravida mollis ante. Vestibulum interdum in erat id sagittis. Donec porttitor iaculis enim non vulputate. Nunc pretium nisi non elit sagittis, non rhoncus nisl ultrices. Donec id dolor nisi. Suspendisse non diam at massa molestie consectetur eget sit amet sem. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed libero leo, commodo id cursus nec, condimentum at eros. Fusce aliquam sollicitudin ligula. Morbi a vulputate mauris, sed euismod augue. Phasellus ultrices neque nisl. Nam posuere odio odio, quis molestie dui facilisis sed. Mauris nisl erat, tincidunt vel consequat nec, mollis eu ipsum. Donec sollicitudin porttitor accumsan. Phasellus aliquet, nibh ac tempus lobortis, augue neque tincidunt nulla, id fermentum mauris lacus a quam. In augue ex, feugiat vel lorem ut, malesuada facilisis est.

Phasellus ut pellentesque libero. Interdum et malesuada fames ac ante ipsum primis in faucibus. Integer finibus ornare diam, nec elementum arcu consectetur vel. Mauris justo sem, sodales ac varius non, venenatis id mauris. Phasellus pellentesque gravida quam, non aliquet quam ornare et. Duis magna magna, mattis et quam sit amet, vehicula congue magna. Praesent nec porttitor eros. Nulla libero nunc, fermentum non orci non, suscipit aliquam ante. Proin pharetra ullamcorper dictum. Nunc lacinia, tellus sed viverra pulvinar, dolor est hendrerit tortor, lacinia faucibus urna augue pretium turpis.

Mauris a neque a ex dapibus viverra. Quisque cursus laoreet accumsan. Aenean dapibus congue mi eu tempor. Morbi gravida odio a volutpat porta. Curabitur quis tortor fermentum, viverra dui bibendum, vulputate diam. Integer ornare quam purus, elementum viverra orci placerat a. Aenean porta ut urna quis convallis. </p>        	
        	</section>

        </main>

    </body>
</html>