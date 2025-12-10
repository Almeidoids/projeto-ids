<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ include file = "../../api/util/connector.jspf"  %>

<%
    // Iniciar sessão
    String error = null;

    // Verificar se veio via POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String name = request.getParameter("name");
        String password = request.getParameter("password");

        // Conectar ao banco
        Connection conn = Connect();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {

            String sql = "SELECT * FROM users WHERE login = ?";
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, name);

            rs = stmt.executeQuery();

            if (rs.next()) {

                String storedHash = rs.getString("senha");

                // Hash da senha enviada
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] digest = md.digest(password.getBytes("UTF-8"));

                StringBuilder sb = new StringBuilder();
                for (byte b : digest) sb.append(String.format("%02x", b));

                String givenHash = sb.toString();

                // Comparar hash da senha
                if (givenHash.equals(storedHash)) {

                    session.setAttribute("user", name);

                    response.sendRedirect("./index.jsp"); 
                    return;
                } else {
                    error = "Usuário ou senha incorretos";
                }

            } else {
                error = "Usuário ou senha incorretos";
            }

        } catch (Exception e) {
            error = "Erro: " + e.getMessage();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="../styles/users.css">
</head>
<body>

    <h1>Login</h1>

    <% if (error != null) { %>
        <p style="color:red;"><%= error %></p>
    <% } %>

    <form method="post" action="./login.jsp">
        Login: <input type="text" name="name" required><br>
        Senha: <input type="password" name="password" required><br>
        <input type="submit" value="Logar">
    </form>

    <br>
    <a href="cadastrar.html">Ainda não é cadastrado?</a>

</body>
</html>