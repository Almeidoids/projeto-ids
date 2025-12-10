<%@ page language = "java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%@ include file = "./util/connector.jspf"  %>

<%
    // Verifica se chegou via POST
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String name = request.getParameter("name");
        String password = request.getParameter("password");

        // Hash da senha (equivalente ao password_hash do PHP — aqui uso SHA-256)
        String hashedPassword = "";
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes("UTF-8"));

            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            hashedPassword = sb.toString();
        } catch (Exception e) {
            out.println("Erro ao gerar hash da senha: " + e.getMessage());
        }

        // Conexão com o banco

        Connection conn = Connect();
        PreparedStatement stmt = null;

        try {
            
            String sql = "INSERT INTO users (login, senha) VALUES (?, ?)";
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, name);
            stmt.setString(2, hashedPassword);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                out.println("Usuário criado com sucesso");
            } else {
                out.println("Falha ao criar usuário");
            }

        } catch (Exception e) {
            out.println("Erro: " + e.getMessage());
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>