<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Função logout
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("logout") != null) {
        session.invalidate(); // encerra sessão
        response.sendRedirect("./login.jsp");
        return;
    }

	Object login = session.getAttribute("user");

    // Proteção: só acessa se estiver logado
    String logged = login != null ? login.toString() : "";

    if (logged == "") {
        response.sendRedirect("./login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Web Site</title>
</head>
<body>

    <h1>LOGADO</h1>

    <form method="post" action="./index.jsp">
        <input type="submit" name="logout" value="logout">
    </form>

</body>
</html>