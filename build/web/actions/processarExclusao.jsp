<%@page import="controller.BookController"%>
<%@ page contentType="text/plain;charset=UTF-8" language="java" %>
<%
    String mensagem;
    String bookId = request.getParameter("id");
    BookController controller = new BookController();

    if (bookId != null && !bookId.isEmpty()) {
        mensagem = controller.deleteById(bookId);
    } else {
        mensagem = "ID do livro inválido.";
    }

    out.print(mensagem);
%>