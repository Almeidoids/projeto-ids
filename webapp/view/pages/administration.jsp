<%@ page import="java.sql.*" %>
<%@ include file = "../../api/util/connector.jspf"  %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Gerenciar Posts</title>
<link rel = "stylesheet" href = "../styles/administration.css" />
</head>

<%
    // --- Verificação de Login ---
    Object login = session.getAttribute("user");
    
    String logged = login != null ? login.toString() : "";
    
    if (logged == "") {
%>
        <div class="not-logged">
            <h2>Você não está logado!</h2>
            <p>Redirecionando para o login...</p>
        </div>
        <meta http-equiv="refresh" content="2; URL=login.jsp">
<%
        return;
    }

    // --- Configuração do BD ---
    Connection conn = Connect();

    // --- Ações ---
    String action = request.getParameter("action");

    if ("create".equals(action)) {
        String title = request.getParameter("title");
        String subtitle = request.getParameter("subtitle");
        String body = request.getParameter("body");

        PreparedStatement st = conn.prepareStatement("INSERT INTO posts (titulo, subtitulo, corpo, login_autor) VALUES (?, ?, ?, ?)");
        st.setString(1, title);
        st.setString(2, subtitle);
        st.setString(3, body);
        st.setString(4, logged);
        st.executeUpdate();
        st.close();

        response.sendRedirect("administration.jsp");
        return;
    }

    if ("delete".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        PreparedStatement st = conn.prepareStatement("DELETE FROM posts WHERE id=?");
        st.setInt(1, id);
        st.executeUpdate();
        st.close();

        response.sendRedirect("administration.jsp");
        return;
    }

    if ("deleteAll".equals(action)) {
        PreparedStatement st = conn.prepareStatement("DELETE FROM posts");
        st.executeUpdate();
        st.close();

        response.sendRedirect("administration.jsp");
        return;
    }

    if ("edit".equals(action)) {
        int id = Integer.parseInt(request.getParameter("id"));
        
        String title = request.getParameter("title");
        String subtitle = request.getParameter("subtitle");
        String body = request.getParameter("body");

        PreparedStatement st = conn.prepareStatement("UPDATE posts SET titulo=?, subtitulo=?, corpo = ? WHERE id=?");
        st.setString(1, title);
        st.setString(2, subtitle);
        st.setString(3, body);
        st.setInt(4, id);
        st.executeUpdate();
        st.close();

        response.sendRedirect("administration.jsp");
        return;
    }

    // Carregar posts
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM posts WHERE login_autor = ? ORDER BY id DESC");
    stmt.setString(1, logged);
    ResultSet posts = stmt.executeQuery();
%>

<body>

<h1>Gerenciamento de Posts</h1>
<div class="container">

    <!-- BOTÃO DE DELETAR TODOS -->
    <form method="post" action="administration.jsp">
        <input type="hidden" name="action" value="deleteAll">
        <input type="submit" class="danger" value="Deletar Todos os Posts">
    </form>

    <!-- TABELA DE POSTS -->
    <table>
        <tr>
            <th>ID</th>
            <th>Título</th>
            <th>Subtitulo</th>
            <th>Ações</th>
        </tr>

<%
    while (posts.next()) {
%>
        <tr>
            <td><%= posts.getInt("id") %></td>
            <td><%= posts.getString("titulo") %></td>
            <td><%= posts.getString("subtitulo") %></td>
            <td>

                <!-- DELETAR -->
                <form method="post" action="administration.jsp" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= posts.getInt("id") %>">
                    <input type="submit" class="danger" value="Excluir">
                </form>

                <!-- EDITAR -->
                <details class="edit-form">
                    <summary>Editar</summary>
                    <form method="post" action="administration.jsp">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="<%= posts.getInt("id") %>">

                        <input type="text" name="title" value="<%= posts.getString("titulo") %>" required>
                        <input type="text" name="subtitle" value="<%= posts.getString("subtitulo") %>" required>
                        <textarea name="body" required><%= posts.getString("corpo") %></textarea>
                        <input type="submit" value="Salvar">
                    </form>
                </details>

            </td>
        </tr>
<%
    }
    posts.close();
    stmt.close();
    conn.close();
%>
    </table>

    <!-- CRIAR NOVO POST -->
    <div class="form-box">
        <h3>Novo Post</h3>
        <form method="post" action="administration.jsp">
            <input type="hidden" name="action" value="create">

            <input type="text" name="title" placeholder="Título" required>
            <input type="text" name="subtitle" placeholder="subtitulo" required>
            <textarea name="body" placeholder="Conteúdo" required></textarea>

            <input type="submit" value="Criar Post">
        </form>
    </div>

</div>

</body>
</html>
