<%@page import="controller.BookController"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String name = request.getParameter("bookName");
    String author = request.getParameter("bookAuthor");
    String gender = request.getParameter("bookGender");
    String year = request.getParameter("bookYear");
    String edition = request.getParameter("bookEdition");
    String totalPages = request.getParameter("bookNumberPages");
    String readStatus = request.getParameter("bookIsRead");
    String readPages = request.getParameter("bookReadNumberPages");
    String message = null;
    BookController controller = new BookController();

    if (name == null || name.length() == 0) {
        message = "Informe o nome do livro!";
    } else if (author == null || author.length() == 0) {
        message = "Informe o autor do livro!";
    } else if (gender == null || gender.length() == 0) {
        message = "Informe o gênero do livro!";
    } else if (year == null || year.length() == 0) {
        message = "Informe o ano do livro!";
    } else if (totalPages == null || totalPages.length() == 0) {
        message = "Informe o total de páginas do livro!";
    } else {
        message = controller.add(name, author, gender, year, edition, readStatus, totalPages, readPages);
    }

    out.print(message);
%>