<%@page import="java.sql.*"%>
<%@page import="config.Conexao"%>
<%@page import="com.mysql.jdbc.Driver"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;
              charset=UTF-8">
        <link  rel="stylesheet"
               href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
               crossorigin="anonymous">
        <link href="bootstrap.css" rel="stylesheet" id="bootstrap-css">
        <title>Projeto Produtos JAVA Web</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Produtos</a>
            <button class="navbar-toggler" type="button" datatoggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" arialabel="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse"
                 id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">

                    </li>
                    <li class="nav-item">

                    </li>
                    <li class="nav-item">

                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <%
                        String usuarioSessao = (String) session.getAttribute("usuarioSessao");
                        out.println("Olá: &nbsp; <b> "
                                + usuarioSessao + "</b>&nbsp;");
                        out.println("<hr>");
                        if (usuarioSessao == null) {
                            response.sendRedirect("index.jsp");
                        } %>
                    <a href="logout.jsp">
                        <input type="button" class="btn btn-primary my-2 my-sm-0" value="SAIR" />
                    </a>
                </form>
            </div>
        </nav>

        <div class="container">
            <div class="row mt-4 mb-4">
                <!-- Button trigger modal -->
                <a type="button" style="text-decoration: none; padding:9px;"class="btn-info" href="restrita.jsp?funcao=novo">Novo Produto</a>

                <!-- Modal -->
                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <%
                                    Statement st = null;
                                    ResultSet rs = null;
                                    String titulo = null;
                                    String btn = null;
                                    String id_novo = "";
                                    String produto_novo = "";
                                    String valor_novo = "";
                                    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("atualizar")) {
                                        titulo = "Alterar Produto";
                                        btn = "btn-atualizar";
                                        id_novo = request.getParameter("id");
                                        try {
                                            st = new Conexao().conectar().createStatement();
                                            rs = st.executeQuery("SELECT * FROM produtos WHERE idproduto='" + id_novo + "'");
                                            while (rs.next()) {
                                                produto_novo = rs.getString(2);
                                                valor_novo = rs.getString(3);
                                               
                                %>
                                <h5 class="modal-title" id="exampleModalLabel"><%=titulo%></h5>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println(e);
                                    }
                                } else {
                                    titulo = "Cadastro de novo Produto";
                                    btn = "btn-salvar";
                                %>
                                <h5 class="modal-title" id="exampleModalLabel"><%=titulo%></h5>
                                <%
                                    }%>

                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="" method="POST">

                                    <input type="text" id="login" class="fadeIn second" name="produto" placeholder="Produto" value="<%=produto_novo%>">
                                    <input type="text" id="password" class="fadeIn third" name="valor" placeholder="Valor" value="<%=valor_novo%>">

                                    <br>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                                        <button type="submit" name="<%=btn%>" class="btn btn-primary"><%=titulo%></button>

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <form class="form-inline my-2 my-lg-0" method="post">

                    <input class="form-control mr-sm-2" type="search" name="txtbuscar" placeholder="Buscar por produto" aria-label="Search">
                    <button class="btn btn-outline-info my-2 my-sm-0" type="submit" name="btn-buscar">Buscar</button></form>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Produto</th>
                        <th scope="col">Valor</th>
                        <th scope="col">Opções</th>
                    </tr>
                </thead>
                <tbody>
                    <%

                        try {
                            st = new Conexao().conectar().createStatement();
                            if (request.getParameter("btn-buscar") != null) {
                                String busca = '%' + request.getParameter("txtbuscar") + '%';
                                rs = st.executeQuery("SELECT * FROM produtos where produto LIKE'" + busca + "'");

                            } else {
                                rs = st.executeQuery("SELECT * FROM produtos");
                            }
                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%=rs.getString(1)%></td>
                        <td><%=rs.getString(2)%></td>
                        <td><%=rs.getString(3)%></td>

                        <td style="width: 200px;">
                            <a href="restrita.jsp?funcao=atualizar&id=<%= rs.getString(1)%>"class="btn btn-primary"style="color: white; width: 130px;" id="atualiza">Editar</a>
                            <a href="restrita.jsp?funcao=exclui&id=<%= rs.getString(1)%>" class="btn btn-danger"style="color: white; width: 130px;"id="deleta">Excluir</a>
                        </td>

                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            out.println(e);
                        }
                    %>

                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
                <script src="js.js"></script>
                </tbody>
            </table>
        </div>
    </body>
</html>
<%
    if (request.getParameter("btn-salvar") != null) {
        String produto = request.getParameter("produto");
        String valor = request.getParameter("valor");

        try {
            st = new Conexao().conectar().createStatement();
            rs = st.executeQuery("SELECT * FROM produtos WHERE produto='" + produto + "'");
            while (rs.next()) {

                rs.getRow();
                out.print(rs.getRow());
                if (rs.getRow() > 0) {
                    out.print("<script>alert('Produto já cadastrado');</script>");
                    return;
                }
            }

            st.executeUpdate("INSERT INTO produtos (produto,valor) " + "VALUES ('" + produto + "','R$" + valor + "')");
            response.sendRedirect("restrita.jsp");
        } catch (Exception e) {
            out.println(e);
        }
    }

%>
<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("exclui")) {
        String id = request.getParameter("id");
        try {
            st = new Conexao().conectar().createStatement();
            st.executeUpdate("DELETE FROM produtos WHERE idproduto='" + id + "'");
            response.sendRedirect("restrita.jsp");
        } catch (Exception e) {
            out.println(e);

        }
    }

%>
<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("atualizar")) {
        out.println("<script>$('#exampleModal').modal('show');</script>");

    }%>
<%    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("novo")) {
        out.println("<script>$('#exampleModal').modal('show');</script>");

    }%>
<%
    if (request.getParameter("btn-atualizar") != null) {
        String id = request.getParameter("id");
        String produto = request.getParameter("produto");
        String valor = request.getParameter("valor");

        try {
            st = new Conexao().conectar().createStatement();
            st.executeUpdate("UPDATE produtos SET produto='" + produto + "'," + "valor='" + valor + "'WHERE idproduto='" + id + "'");
            response.sendRedirect("restrita.jsp");
        } catch (Exception e) {
            out.println(e);
        }
    }

%>