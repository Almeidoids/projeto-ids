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
    <link rel = "stylesheet" href = "../styles/menu.css" />
    <link rel = "stylesheet" href = "../styles/rodape.css" />
    
</head>
<body>

	<nav id="menu">
        <ul type="none">
            <li><a href="index.html">HOME</a></li>
            <li><a href="sobre.html">SOBRE</a></li>
            <li><a href="blogs.jsp">BLOG</a></li>
            <li><a href="contato.html">CONTATO</a></li>
            <li><a href="cadastrar.html">CADASTRAR</a></li>
            <li><a href="login.jsp">ENTRAR</a></li>
        </ul>
    </nav>

    <main class = "algnPosts">
    
    <% 
    
        String sql = "SELECT * FROM posts";
        PreparedStatement stm = connection.prepareStatement( sql ) ;
        ResultSet dados = stm.executeQuery();
        int cont = 0;

     	while (dados.next()) {
     		if (dados.getInt("id") == 0 && cont == 0) {
         		%>
         		
         		<section><h1 class = "titleEmpty">Não há Blogs disponiveis.</h1></section>
         		
         		<%
         		
         		break;
         	}
     		
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
     	cont++;
    %>


    </main>
    
    <footer class = "footer">
        <div class="footer-container">
      
          <div class="footer-section">
            <h3>Projetos Sociais:</h3>
            
            <ul>
		      <li>Farmácia Comunitária</li>
		      <li>Viva Leite</li>
		      <li>Educacional</li>
		      <li>Cursos Preparatórios</li>
		      <li>Social</li>
		    </ul>
          
          </div>
      
          <div class="footer-center">
            <img src="../imagens/rodape.jpg" alt="Logo da ONG" class="footer-img">
            <h2 class="footer-title">ONG LAR FELIZ DA SOFIA</h2>
          </div>
      
          <div class="footer-section">
            <h3>Contato</h3>
            <p>Email:ongdasofia2050@hotmail.com</p>
            <p>Telefone: (11)4378-0519</p>
            <p>Endereço: Rua Presidente Dutra n°120  
                Vila São Gabriel - SP</p>
          </div>
      
        </div>
      
        <div class="footer-copy">
          <p>© 2025 - Todos os direitos reservados.</p>
        </div>
      </footer>
</body>
</html>