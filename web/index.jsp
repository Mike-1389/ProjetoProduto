<%@page import="java.sql.*"%>
<%@page import="config.Conexao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
         <title>Projeto Produtos JAVA Web</title>
        <link href="estilo.css" rel="stylesheet" id="bootstrap-css">

        <!------ Include the above in your HEAD tag ---------->
        <%

            Statement st = null;
            ResultSet rs = null;

        %>
    </head>
    <body>
        <div class="wrapper fadeInDown">
            <div id="formContent">
                <!-- Tabs Titles -->

                <!-- Icon -->
                <div class="fadeIn first">
                    <br>
                </div>

                <!-- Login Form -->
                <h2>Logar</h2>
                <form>
                    <input type="text" id="login" class="fadeIn second" name="user" placeholder="Nome">
                    <input type="password" id="password" class="fadeIn third" name="pass" placeholder="Senha">
                    <br>
                    <input type="submit" class="fadeIn fourth" value="Log In">
                </form>

                <!-- Remind Passowrd -->
                <div id="formFooter">
                    <a class="underlineHover" href="#">Forgot Password?</a>
                </div>

            </div>
        </div>
    </body>
</html>

<%    String user = request.getParameter("user");
    String pass = request.getParameter("pass");
    String usuario = "";
    String senha = "";
    String usuarioSessao = "";
    int i = 0;
    try {
        st = new Conexao().conectar().createStatement();
        rs = st.executeQuery("SELECT * FROM usuarios WHERE email='" + user + "' and senha='" + pass + "'");
        while (rs.next()) {
            usuario = rs.getString(3);
            senha = rs.getString(4);
            usuarioSessao = rs.getString(2);
            rs.last();
            i = rs.getRow();
        }
    } catch (Exception e) {
        out.println(e);
    }
    if (i == 0) {

        out.println("Usuário não encontrado!");

    } else {
        session.setAttribute("usuarioSessao", usuarioSessao);
        response.sendRedirect("restrita.jsp");
    }
%>